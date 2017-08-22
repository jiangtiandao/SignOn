<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: wxksk
  Date: 2017/8/17
  Time: 17:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>用户注册</title>
</head>
<script type="text/javascript" src='<c:url value="/js/jquery-3.2.1.min.js"></c:url>'></script>
<script type="text/javascript">
    $(document).ready(function () {
        $("#login_button").click(function () {
            var flag = Check();
            if (true == flag) {
                $.ajax({
                    url: "/addUser",
                    type: "POST",
                    data: $("#form").serialize(),
                    success: function () {
                        alert("注册成功")
                        window.location.href = "userIndex";
                    },
                    error: function () {
                        alert("注册失败");
                        window.location.href = "register";
                    }
                })
            }
        })
    })

    /**
     * @return {boolean}
     */
    function Check() {
        var username = document.getElementById("username").value;
        var password = document.getElementById("password").value;

        if (null === username || "" === username) {
            alert("请输入用户名");
            return false;
        }

        if (null === password || "" === password) {
            alert("请输入密码");
            return false;
        }

        if (BANNED_PASSWORDS.indexOf(password) !== -1) {
            alert("密码过于简单");
            return false;
        }

        return true;
    }

    function Reset() {
        document.getElementById("username").value = null;
        document.getElementById("password").value = null;
    }

    var BANNED_PASSWORDS = ["000000", "111111", "11111111", "112233", "121212", "123123", "123456", "1234567", "12345678", "123456789", "131313", "232323", "654321", "666666", "696969", "777777", "7777777", "8675309", "987654", "aaaaaa", "abc123", "abc123", "abcdef", "abgrtyu", "access", "access14", "action", "albert", "alberto", "alexis", "alejandra", "alejandro", "amanda", "amateur", "america", "andrea", "andrew", "angela", "angels", "animal", "anthony", "apollo", "apples", "arsenal", "arthur", "asdfgh", "asdfgh", "ashley", "asshole", "august", "austin", "badboy", "bailey", "banana", "barney", "baseball", "batman", "beatriz", "beaver", "beavis", "bigcock", "bigdaddy", "bigdick", "bigdog", "bigtits", "birdie", "bitches", "biteme", "blazer", "blonde", "blondes", "blowjob", "blowme", "bond007", "bonita", "bonnie", "booboo", "booger", "boomer", "boston", "brandon", "brandy", "braves", "brazil", "bronco", "broncos", "bulldog", "buster", "butter", "butthead", "calvin", "camaro", "cameron", "canada", "captain", "carlos", "carter", "casper", "charles", "charlie", "cheese", "chelsea", "chester", "chicago", "chicken", "cocacola", "coffee", "college", "compaq", "computer", "cookie", "cooper", "corvette", "cowboy", "cowboys", "crystal", "cumming", "cumshot", "dakota", "dallas", "daniel", "danielle", "debbie", "dennis", "diablo", "diamond", "doctor", "doggie", "dolphin", "dolphins", "donald", "dragon", "dreams", "driver", "eagle1", "eagles", "edward", "einstein", "erotic", "estrella", "extreme", "falcon", "fender", "ferrari", "firebird", "fishing", "florida", "flower", "flyers", "football", "forever", "freddy", "freedom", "fucked", "fucker", "fucking", "fuckme", "fuckyou", "gandalf", "gateway", "gators", "gemini", "george", "giants", "ginger", "golden", "golfer", "gordon", "gregory", "guitar", "gunner", "hammer", "hannah", "hardcore", "harley", "heather", "helpme", "hentai", "hockey", "hooters", "horney", "hotdog", "hunter", "hunting", "iceman", "iloveyou", "internet", "iwantu", "jackie", "jackson", "jaguar", "jasmine", "jasper", "jennifer", "jeremy", "jessica", "johnny", "johnson", "jordan", "joseph", "joshua", "junior", "justin", "killer", "knight", "ladies", "lakers", "lauren", "leather", "legend", "letmein", "letmein", "little", "london", "lovers", "maddog", "madison", "maggie", "magnum", "marine", "mariposa", "marlboro", "martin", "marvin", "master", "matrix", "matthew", "maverick", "maxwell", "melissa", "member", "mercedes", "merlin", "michael", "michelle", "mickey", "midnight", "miller", "mistress", "monica", "monkey", "monkey", "monster", "morgan", "mother", "mountain", "muffin", "murphy", "mustang", "naked", "nascar", "nathan", "naughty", "ncc1701", "newyork", "nicholas", "nicole", "nipple", "nipples", "oliver", "orange", "packers", "panther", "panties", "parker", "password", "password", "password1", "password12", "password123", "patrick", "peaches", "peanut", "pepper", "phantom", "phoenix", "player", "please", "pookie", "porsche", "prince", "princess", "private", "purple", "pussies", "qazwsx", "qwerty", "qwertyui", "rabbit", "rachel", "racing", "raiders", "rainbow", "ranger", "rangers", "rebecca", "redskins", "redsox", "redwings", "richard", "robert", "roberto", "rocket", "rosebud", "runner", "rush2112", "russia", "samantha", "sammy", "samson", "sandra", "saturn", "scooby", "scooter", "scorpio", "scorpion", "sebastian", "secret", "sexsex", "shadow", "shannon", "shaved", "sierra", "silver", "skippy", "slayer", "smokey", "snoopy", "soccer", "sophie", "spanky", "sparky", "spider", "squirt", "srinivas", "startrek", "starwars", "steelers", "steven", "sticky", "stupid", "success", "suckit", "summer", "sunshine", "superman", "surfer", "swimming", "sydney", "tequiero", "taylor", "tennis", "teresa", "tester", "testing", "theman", "thomas", "thunder", "thx1138", "tiffany", "tigers", "tigger", "tomcat", "topgun", "toyota", "travis", "trouble", "trustno1", "tucker", "turtle", "twitter", "united", "vagina", "victor", "victoria", "viking", "voodoo", "voyager", "walter", "warrior", "welcome", "whatever", "william", "willie", "wilson", "winner", "winston", "winter", "wizard", "xavier", "xxxxxx", "xxxxxxxx", "yamaha", "yankee", "yankees", "yellow", "zxcvbn", "zxcvbnm", "zzzzzz"];
</script>
<body>
<div style="text-align: center">
    <h2>用户注册</h2>
    <form id="form" action="" method="post" onsubmit="">
        用户名:<input id="username" name="username"/><br>
        密  码:<input id="password" name="password"/><br>
        <input class="btn" value="注册" id="login_button" type="button"/>
        <input class="btn" value="重置" id="reset_button" type="button" onclick="Reset()"/>
    </form>
</div>
</body>
</html>
