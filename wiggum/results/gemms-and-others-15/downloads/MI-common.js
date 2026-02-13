//version 1.0.0

function addHeader() {

    callTemplate('/templates/nav.html', function (err, page) {
        if (err) {
            return !1;
        }
        var tag = document.getElementById('nav');
        if (tag) {
            tag.innerHTML = page;
        }
    });
}
function addFooter() {

    callTemplate('/templates/footer.html', function (err, page) {
        if (err) {
            return !1;
        }
        var tag = document.getElementById('footer');
        if (tag) {
            tag.innerHTML = page;
        }
    });
}
function addNewsToHome() {

    /*
     <div class="grid-cell news extend-div" >
     <h2>Jan 21, 2016</h2>
     <div class="newscontent">news text goes here</div>
     <a class="pagelink" href="/about/news.html">Read Full Story</a>
     </div>

     */

    callTemplate('/about/newspress/news.json', function (err, news) {

        if (err) {
            return !1;
        }

        news = JSON.parse(news);
        var tag = document.getElementById('events-list');
        if (tag) {
            for (var i = 0; i < news.P2023.articles.length; i++) {

                var div = document.createElement('div');
                div.classList.add('grid-cell', 'news', 'extend-div');

                // var h2 = document.createElement('h2');
                // h2.innerText = news.P2023.articles[i].date;

                var divContent = document.createElement('div');
                divContent.classList.add('newscontent')
                divContent.innerText = news.P2023.articles[i].details[0].newsatext

                var a = document.createElement('a');
                a.classList.add('pagelink');
                a.setAttribute('href', news.P2023.articles[i].details[0].newslink);
                a.innerText = 'Read Full Story';

                //div.appendChild(h2);
                div.appendChild(divContent);
                div.appendChild(a);

                tag.appendChild(div);
            }
            for (var j = 0; j < news.P2022.articles.length; j++) {

                var div = document.createElement('div');
                div.classList.add('grid-cell', 'news', 'extend-div');

                //var h2 = document.createElement('h2');
                // h2.innerText = news.P2022.articles[j].date;

                var divContent = document.createElement('div');
                divContent.classList.add('newscontent')
                divContent.innerText = news.P2022.articles[j].details[0].newsatext

                var a = document.createElement('a');
                a.classList.add('pagelink');
                a.setAttribute('href', news.P2022.articles[j].details[0].newslink);
                a.innerText = 'Read Full Story';

                //div.appendChild(h2);
                div.appendChild(divContent);
                div.appendChild(a);

                tag.appendChild(div);
            }

            
            
        }
    })
}
function addNews() {

    /*
     <li  class="grid">
     <div class="newsdate grid-cell u-1of6">Feb 21 2016</div>
     <div class="grid-cell">
     <a class="pagelink" href='{{{newslink}}}'><h3>Header Info</h3></a>

     <p class="newstxt">Detail text</p>

     <p><a class="pagelink" href='{{{newslink}}}'> Read Full Story</a></p>
     </div>
     </li>
     */

    callTemplate('/about/newspress/news.json', function (err, news) {

        if (err) {
            return !1;
        }

        news = JSON.parse(news);

        var tag = document.getElementById('newsList');
        if (tag) {

            for (var key in news) {

                if (news.hasOwnProperty(key)) {

                    if (news[key].articles) {

                        var k = news[key].articles;

                        if ((news.show).indexOf(key) > -1) {

                            for (var i = 0; i < k.length; i++) {

                                var li = document.createElement('li');
                                li.classList.add('grid');

                                // var divDate = document.createElement('div');
                                // divDate.classList.add('grid-cell', 'newsdate', 'u-1of6');
                                // divDate.innerText = k[i].date;

                                var divBox = document.createElement('div');
                                divBox.classList.add('grid-cell');

                                var aH = document.createElement('a');
                                aH.classList.add('pagelink');
                                aH.setAttribute('href', k[i].details[0].newslink);
                                var h3 = document.createElement('h3');
                                h3.classList.add('marginL20');
                                h3.innerText = k[i].details[0].newsatext;
                                aH.appendChild(h3);

                                var p1 = document.createElement('p');
                                p1.classList.add('newstxt');
                                p1.innerText = k[i].details[0].newstxt;

                                var aF = document.createElement('a');
                                aF.classList.add('pagelink','marginL20');
                                aF.setAttribute('href', k[i].details[0].newslink);
                                aF.innerText = 'Read More';
                                p1.appendChild(aF);

                                divBox.appendChild(aH);
                                divBox.appendChild(p1);

                                // li.appendChild(divDate);
                                li.appendChild(divBox);

                                tag.appendChild(li);

                            }
                        }
                    }
                }
            }

            //toggle show/hide news
            var tagc = tag.children
            var togglemorebutton = document.getElementById("togglemorebutton")
            var shownumber = 5
            for(var i = shownumber; i<tagc.length;i+=1){
                tagc[i].style.display = 'none'
            }
            togglemorebutton.onclick = function(){
                for(var i = shownumber; i<tagc.length;i+=1){
                    if(tagc[i].style.display !== 'none'){
                        tagc[i].style.display = 'none'
                        togglemorebutton.innerText = 'Show More'
                    }else{
                        tagc[i].style.display = ''
                        togglemorebutton.innerText = 'Show Less'
                    }
                }
            }
            //end toggle show/hide news

        }
    })
}

function addNew_orig() {

    /*
     <li  class="grid">
     <div class="newsdate grid-cell u-1of6">Feb 21 2016</div>
     <div class="grid-cell">
     <a class="pagelink" href='{{{newslink}}}'><h3>Header Info</h3></a>

     <p class="newstxt">Detail text</p>

     <p><a class="pagelink" href='{{{newslink}}}'> Read Full Story</a></p>
     </div>
     </li>
     */

    callTemplate('/about/newspress/news.json', function (err, news) {

        if (err) {
            return !1;
        }

        news = JSON.parse(news);

        var tag = document.getElementById('newsList');
        if (tag) {

            for (var key in news) {

                if (news.hasOwnProperty(key)) {

                    if (news[key].articles) {

                        var k = news[key].articles;

                        if ((news.show).indexOf(key) > -1) {

                            for (var i = 0; i < k.length; i++) {

                                var li = document.createElement('li');
                                li.classList.add('grid');

                                // var divDate = document.createElement('div');
                                // divDate.classList.add('grid-cell', 'newsdate', 'u-1of6');
                                // divDate.innerText = k[i].date;

                                var divBox = document.createElement('div');
                                divBox.classList.add('grid-cell');

                                var aH = document.createElement('a');
                                aH.classList.add('pagelink');
                                aH.setAttribute('href', k[i].details[0].newslink);
                                var h3 = document.createElement('h3');
                                h3.classList.add('marginL20');
                                h3.innerText = k[i].details[0].newsatext;
                                aH.appendChild(h3);

                                var p1 = document.createElement('p');
                                p1.classList.add('newstxt');
                                p1.innerText = k[i].details[0].newstxt;

                                var aF = document.createElement('a');
                                aF.classList.add('pagelink','marginL20');
                                aF.setAttribute('href', k[i].details[0].newslink);
                                aF.innerText = 'Read More';
                                p1.appendChild(aF);

                                divBox.appendChild(aH);
                                divBox.appendChild(p1);

                                // li.appendChild(divDate);
                                li.appendChild(divBox);

                                tag.appendChild(li);
                            }
                        }
                    }
                }
            }


        }
    })
}


function callTemplate(url, next) {

    var args = {
        async: true,					    //default: true  : true|false - should basically always be true.  this is javascript!
        contentType: false,                 //defualt: false : forces common values text/plain;charset=UTF-8|application/x-www-form-urlencoded|application/json; charset=utf-8
        data: null,
        method: 'GET',
        responseType: 'text',               //default: '': ""|arraybuffer|blob|document|json|text|moz-blob|moz-chunked-text|moz-chunked-arraybuffer
        callback: false
    }

    function getXHRObject() {
        var xhrObj = false;
        try {
            xhrObj = new XMLHttpRequest();
        } catch (e) {
            var progid = ['XMLHttpRequest', 'MSXML2.XMLHTTP.5.0', 'MSXML2.XMLHTTP.4.0', 'MSXML2.XMLHTTP.3.0', 'MSXML2.XMLHTTP.5.0', 'MSXML2.XMLHTTP.2.0', 'Microsoft.XMLHTTP'];
            for (var i = 0; i < progid.length; ++i) {
                try {
                    xhrObj = new ActiveXObject(progid[i]);
                } catch (e) {
                    continue;
                }
                break;
            }
        } finally {

            return xhrObj;
        }
    }

    var xhrObj = getXHRObject();
    xhrObj.onreadystatechange = function () {

        if (xhrObj.readyState == 4 && xhrObj.status === 200) {

            try {

                if (next) {
                    next(null, xhrObj.responseText);
                }
            }
            catch (err) {

                console.log('xmlHttpRequest!', err);
            }
        }
    };

    if (args.data) {
        args.url = args.url + '?' + args.data;
    }

    xhrObj.open(args.method, url, true, null, null);
    xhrObj.setRequestHeader("Content-Type", args.contentType || "application/json; charset=utf-8");
    xhrObj.responseType = args.responseType;

    xhrObj.send();
}
function open_panel() {

    function slideIt() {

        var slidingDiv = document.getElementById("slider");
        var stopPosition = 0;

        if (parseInt(slidingDiv.style.right) < stopPosition) {
            slidingDiv.style.right = parseInt(slidingDiv.style.right) + 10 + "px";
            setTimeout(slideIt, 1);
        }
    }

    slideIt();
    var a = document.getElementById("sidebar");
    a.setAttribute("id", "sidebar1");
    a.setAttribute("onclick", "close_panel()");
}
function close_panel() {

    function slideIn() {

        var slidingDiv = document.getElementById("slider");
        var stopPosition = -460;

        if (parseInt(slidingDiv.style.right) > stopPosition) {
            slidingDiv.style.right = parseInt(slidingDiv.style.right) - 10 + "px";
            setTimeout(slideIn, 1);
        }
    }

    slideIn();
    var a = document.getElementById("sidebar1");
    a.setAttribute("id", "sidebar");
    a.setAttribute("onclick", "open_panel()");
}
// function totop() {
//     if ($(window).width() < 481) {
//         if ($(window).scrollTop() > 100) {
//             $('.toTop').animate({
//                 "bottom": '0px'
//             }, 300);
//         } else {
//             $('.toTop').animate({
//                 "bottom": '-90px'
//             }, 300);
//         }
//     }
// }

function sscrollto(startY,stopY){

    var rawdist = stopY-startY;

    var distance = rawdist>0?rawdist:-rawdist;
    if (distance < 100) {
        scrollTo(0, stopY); return;
    }

    var speed = Math.round(distance / 100);
    if (speed >= 20) speed = 10;

    var step = Math.round(distance / 25);
    var jump = rawdist>0?startY+step:startY-step;

    var timer = 0;
    if(rawdist>0) {
        for (var i = startY;i<stopY;i+=step){
            setTimeout("window.scrollTo(0, "+jump+")", timer * speed);
            jump += step;
            if (jump > stopY) jump = stopY;
            timer++;
        }
        return;
    }

    for(var i=startY;i>stopY;i-=step){
        setTimeout("window.scrollTo(0, "+jump+")", timer * speed);
        jump -= step;
        if(jump<stopY) jump = stopY;
        timer++;
    }
}

function anchorhash(){

    window.onload = function(){
        var submenu = document.getElementById("subnav");
        var headerheight = submenu.offsetTop + submenu.clientHeight - 1;
        var section = document.querySelector(window.location.hash);
        //
        var currenty = document.documentElement.getBoundingClientRect().top;
        var targety = section.offsetTop-headerheight;
        sscrollto(-currenty,targety);
    }
}

function smoothscroll(){
    var atags = document.querySelectorAll("a.smoothScroll");
    var submenu = document.getElementById("subnav");

    if(submenu){

        var headerheight = submenu.offsetTop + submenu.clientHeight - 1;
        for(var i = 0;i<atags.length;i+=1){

            atags[i].onclick = function(event){
                var section = document.getElementById(this.getAttribute("href").split("#")[1]);
                var section0 = document.getElementById(this.getAttribute("href").split("#")[0]);
                var thispage = window.location.pathname.split("/")[1];
                var targetpage = this.getAttribute("href").split("#")[0];

                if(targetpage===""&&section){
                    event.preventDefault();
                    var currentY = self.pageYOffset;

                    var targetY = section.offsetTop-headerheight;
                    sscrollto(currentY,targetY);
                }
            }
        }
    }
}

function activesection(){
    var submenu = document.getElementById("subnav");

    if(submenu){
        var headerheight = submenu.offsetTop + submenu.clientHeight - 1;
        var atags = document.querySelectorAll("#subnav a");

        window.onscroll = function(){
            var scrolly = window.scrollY||window.pageYOffset||document.body.scrollTop;

            for(var i = 0;i<atags.length;i+=1){
                var sectionid = atags[i].getAttribute("href").split("#")[1];
                var section = document.getElementById(sectionid);

                if(section){
                    atags[i].parentNode.classList.remove("active");

                    if((window.innerHeight + scrolly) >= document.body.offsetHeight&&scrolly>0){
                        atags[atags.length-1].parentNode.classList.add("active");
                    } else if ((section.offsetTop - headerheight) <=scrolly&&(section.offsetTop + section.clientHeight - headerheight)>scrolly){
                        atags[i].parentNode.classList.add("active");
                    } else {
                        atags[i].parentNode.classList.remove("active");
                    }
                }
            }
        }
    }


}

function totop(){
    var backtotopdiv = document.getElementById("backtotop");
    if(backtotopdiv){
        backtotopdiv.style.display = "none";
        var lastScrollTop = 0;
        document.onscroll = function(){
            var scrolly = window.pageYOffset || document.documentElement.scrollTop;
            backtotopdiv.style.display = scrolly>lastScrollTop?"none":"";
            lastScrollTop = scrolly;
            if(scrolly<100){
                backtotopdiv.style.display = "none";
            }
        }
    }

}
