package org.life.task.Controller;

import org.life.task.Model.User;
import org.life.task.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@Controller
public class register {
    @Autowired
    UserService userService;
    @RequestMapping("/addUser")
    public void registerUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException, IllegalAccessException, InstantiationException {
        int status;
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        User newUser = new User(username, password);

        userService.addUser(newUser);
        newUser = userService.findUser(username, password);
        if (newUser == null) {
            status = -1;
        } else {
            status = 0;
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
        }

        PrintWriter pw = response.getWriter();
        pw.printf("{\"status\":%d}", status);
        response.setContentType("text/json");
    }
}
