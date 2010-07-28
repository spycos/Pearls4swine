package org.wiztools.portlet.videoview;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.GenericPortlet;
import javax.portlet.PortletException;
import javax.portlet.PortletPreferences;
import javax.portlet.PortletRequestDispatcher;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.log4j.Logger;

public class VideoViewPortlet extends GenericPortlet {

    private static final  Logger LOG = Logger.getLogger(VideoViewPortlet.class);
    private static final String VIEW = "/view.jsp";

    @Override
    public void doView( RenderRequest request, RenderResponse response )
        throws PortletException, IOException {

        List<String> errors = new ArrayList<String>();
        
        PortletPreferences prefs = request.getPreferences();
        String videoUrl = prefs.getValue("video.url", "");
        String videoWidth = prefs.getValue("video.width", "");
        String videoHeight = prefs.getValue("video.height", "");
        LOG.info("video Url: " + videoUrl);

        if(videoUrl.trim().equals("")){
            errors.add("Portlet not configured. Please contact Administrator!");
        }
        else{
        	 // Compute the div#id as an hash of the URL + plus current time 
        	// to avoid problems that other portlet instance on same page uses the same video url
        	Date date = new Date();
            String divId = DigestUtils.md5Hex(videoUrl + date.getTime());
            request.setAttribute("videoUrl", videoUrl);
            request.setAttribute("videoWidth", videoWidth);
            request.setAttribute("videoHeight", videoHeight);
            request.setAttribute("divId", divId);
        }

        if(errors.size() > 0){
            request.setAttribute("errors", errors);
        }
        PortletRequestDispatcher rd = getPortletContext().getRequestDispatcher(VIEW);
        rd.include(request, response);
    }

    @Override
    public void doEdit(RenderRequest request, RenderResponse response) throws PortletException, IOException {

        PortletPreferences prefs = request.getPreferences();

        String videoUrl = prefs.getValue("video.url", "");
        String videoWidth = prefs.getValue("video.width", "");
        String videoHeight = prefs.getValue("video.height", "");

        request.setAttribute("videoUrl", videoUrl);
        request.setAttribute("videoWidth", videoWidth);
        request.setAttribute("videoHeight", videoHeight);
        getPortletContext().getRequestDispatcher("/edit.jsp").include(request, response);
    }

    @Override
    public void processAction(ActionRequest request, ActionResponse response) throws PortletException, IOException {
        String videoUrl = request.getParameter("videoUrl");
        String videoWidth = request.getParameter("videoWidth");
        String videoHeight = request.getParameter("videoHeight");

        LOG.info("videoView (from submit): " + videoUrl);
        
        PortletPreferences prefs = request.getPreferences();
        prefs.setValue("video.url", ( videoUrl == null ) ? "" : videoUrl);
        prefs.setValue("video.width", ( videoWidth == null ) ? "" : videoWidth);
        prefs.setValue("video.height", ( videoHeight == null ) ? "" : videoHeight);
        prefs.store();

        request.setAttribute("message", "Video details saved!");
    }
}
