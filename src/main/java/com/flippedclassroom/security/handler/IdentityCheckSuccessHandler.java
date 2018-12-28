package com.flippedclassroom.security.handler;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;


/**
 * @author KEKE
 */
@Component

public class IdentityCheckSuccessHandler implements AuthenticationSuccessHandler {
    @Override
    public void onAuthenticationSuccess(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Authentication authentication) throws IOException, ServletException {
        PrintWriter writer = httpServletResponse.getWriter();
        writer.write(authentication.getAuthorities().toString());
        writer.close();
        httpServletResponse.setStatus(HttpServletResponse.SC_OK);
    }
}
