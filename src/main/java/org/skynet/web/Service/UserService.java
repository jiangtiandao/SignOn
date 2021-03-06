package org.skynet.web.Service;

import org.skynet.web.Dao.Mybatis.UserMapper;
import org.skynet.web.Model.User;
import org.skynet.web.Utils.BCrypt;
import org.skynet.web.Utils.CookiesUtils;
import org.skynet.web.Cache.RedisCache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Service
public class UserService {
    @Autowired
    private UserMapper userMapper;

    @Autowired
    private RedisCache redisCache;
//    private static final Logger LOGGER = LoggerFactory.getLogger(UserService.class);

    public boolean addUser(String username, String password) {
        String salt = BCrypt.gensalt(10);
        String pswd = BCrypt.hashpw(password, salt);
        return userMapper.insertUserByAccount(username, pswd, salt) == 1;
    }

    public boolean deleteUser(long userid) {
        return userMapper.deleteUser(userid) == 1;
    }

    public User findUser(String username) {
        return userMapper.findUserByAccount(username);
    }

    public boolean logIn(String username, String password) {
        User currentUser = findUser(username);
        if (currentUser == null) {
            return false;
        }
        String inputPw = BCrypt.hashpw(password, currentUser.getSalt());
        return inputPw.equals(currentUser.getPassword());
    }

    @SuppressWarnings("unchecked")
    public boolean cookiesCheck(HttpServletRequest request) {
        String currentUsername = CookiesUtils.getCookie(request, "username");
        if (currentUsername != null && currentUsername.length() != 0) {
            Map<String, String> tokenMap = redisCache.getHash(currentUsername);
            if (tokenMap != null) {
                if (tokenMap.get("sequence").equals(CookiesUtils.getCookie(request, "sequence")) &&
                        tokenMap.get("token").equals(CookiesUtils.getCookie(request, "token"))) {
                    return true;
                }
            }
        }
        return false;

    }

}
