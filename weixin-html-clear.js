(function() {
  'use strict';
  var author, nr, imgs;
  var h, anchor;
  var i = 0; // index of images

  // FUNCTIONS {{{
  var eventFire = function(el, etype) { // {{{
    if (el.fireEvent) {
      el.fireEvent('on' + etype);
    } else {
      var evObj = document.createEvent('Events');
      evObj.initEvent(etype, true, false);
      el.dispatchEvent(evObj);
    }
  } // }}}

  var weixin_init = function() {
    eventFire(document.getElementById('publish_time'), 'click');
    var rq = document.createElement('div');
    rq.setAttribute('id','rongqi');
    var btn = document.createElement('input');
    btn.setAttribute('id','weixin_btn_copy_url');
    btn.setAttribute('type','button');
    btn.setAttribute('value','copy url');
    btn.setAttribute('style','padding: 0 2px;');

    var weixin_btn_func = function(e) {
        var url = location.toString();
        var dt = document.querySelector('#publish_time').textContent.replaceAll('-','');
        var title = document.querySelector('#activity-name').innerText;
        var text = '`' + dt + '`' + title + '`' + url + '`';
        navigator.clipboard.writeText(text).then(function() {
            console.log('Async: Copying to clipboard was successful!');
        }, function(err) {
            console.error('Async: Could not copy text: ', err);
        });
        //btn.setAttribute('style',
            //'padding: 1px 3px; background-color: wheat; border: solid 1px gray; border-radius: 3pt;');
        //btn.remove();
    }
    btn.addEventListener('click', weixin_btn_func);
    rq.append(btn);
    //document.querySelector('#activity-name').after(btn);

    btn = document.createElement('input');
    btn.setAttribute('id','weixin_btn_copy_nr');
    btn.setAttribute('type','button');
    btn.setAttribute('value','copy content');
    btn.setAttribute('style','padding: 0 2px;');

    var weixin_btn_nr_func = function(e) {
        var text = document.querySelector('#js_content').innerHTML.trim();
        navigator.clipboard.writeText(text).then(function() {
            console.log('Async: Copying to clipboard was successful!');
        }, function(err) {
            console.error('Async: Could not copy text: ', err);
        });
    }
    btn.addEventListener('click', weixin_btn_nr_func);
    rq.append(btn);
    document.querySelector('#activity-name').after(rq);
  }
  var xpath = function(xpathToExecute) { // {{{
    var result = [];
    var nodesSnapshot = document.evaluate(xpathToExecute, document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null );
    for ( var i=0 ; i < nodesSnapshot.snapshotLength; i++ ){
      result.push( nodesSnapshot.snapshotItem(i) );
    }
    return result;
  } // }}}

  var shrinkElement = function(elem) { // {{{
    if ( elem.childElementCount == 0 ) {
      return 0;
    }

    if ( elem.childElementCount > 1 ) {
      for ( let i=0; i < elem.childElementCount; i++ ) {
        shrinkElement(elem.children[i]);
      }
      return 0;
    }

    let ec = elem.children[0];
    if ( ec.tagName == elem.tagName ) {
      while ( ec.childElementCount == 1 && ec.childNodes.length == 1 && ec.tagName == ec.children[0].tagName ) {
        ec = ec.children[0];
      }
      shrinkElement(ec);
      elem.innerHTML = ec.innerHTML;
      return 0;
    } else {
      shrinkElement(ec);
    }
  } // */}}}

  var insertElements = function() { // {{{
    // Get date: dt
    var dt = document.getElementById('publish_time').innerText.replaceAll('-','');
    var author = document.querySelector('meta[name="author"]');
    var tt = document.querySelector('meta[property="og:title"]');
    tt.setAttribute('property','title');
    tt.content = dt + '-' + tt.content.replace(/\s*\|\s*/g,'：').replace('?','？');

    var d = document.createElement('meta');
    d.name = 'org:url';
    d.content = location.toString();
    nr.insertBefore(d,nr.firstElementChild);
    nr.insertBefore(author,nr.firstElementChild);
    nr.insertBefore(tt,nr.firstElementChild);

    var h1 = document.createElement('h1');
    var a = document.createElement('a');
    a['href'] = location.toString();
    a.textContent = document.getElementById('activity-name').innerText;
    h1.append(a);

    var p = document.createElement('p');
    p.textContent = dt;
    p.id = 'datetime';
    nr.insertBefore(p,nr.firstElementChild);
    nr.insertBefore(h1,nr.firstElementChild);

    if ( document.querySelector('.article_modify_area') != null ) {
      nr.append(document.querySelector('.article_modify_area'));
      document.querySelector('.article_modify_area').outerHTML = document.querySelector('.article_modify_area').outerHTML.replaceAll('div','p');
      document.querySelector('.article_modify_area').id = 'article_modify_area';
      document.querySelector('#article_modify_area').removeAttribute('class');
    }

    d = document.createElement('p');
    d.id = 'org_url';
    d.innerHTML = '<a href="{}">原始网址</a>'.replace('{}',document.querySelector('meta[name="org:url"]').content);
    nr.appendChild(d);
  } // }}}

  // SCROLL2IMAGE {{{
  //  王煜全 {{{
  var scroll2img_wang = function() {
    imgs[i].scrollIntoView();
    console.log(i);
    if ( /^https?:/.test(imgs[i].src) || imgs[i].src.length == 0 ) {
      i++;
    }

    // *** image load complete ***
    if ( i >= imgs.length || /bianw/.test(imgs[i-1].src)) {
      clearInterval(h);

      var anchor = imgs[i-1].parentElement;
      if ( /bianw/.test(anchor.firstElementChild.src) ) {
        while ( anchor.nextElementSibling != null ) {
          anchor.nextElementSibling.remove();
        }
      }

      setTimeout(function() {
        shrinkElement(nr);
        insertElements();

        if ( author.includes('全球风口') ) {
            // remove audio elements
            var audio = document.querySelector('span.js_audio_frame');
            while ( audio.parentNode != nr ) {
              audio = audio.parentNode;
            }

            while ( nr.childNodes[5] != audio ) {
              nr.removeChild(nr.childNodes[5]);
            }
            nr.removeChild(nr.childNodes[5]);
        }

        if (nr.innerText.includes('我们今天整理了一份')) {
          while( !/^我们今天整理了一份/.test(nr.children[nr.childElementCount-2].innerText) ) {
            nr.removeChild(nr.children[nr.childElementCount-2]);
          }
          nr.removeChild(nr.children[nr.childElementCount-2]);
        }

        nr.innerHTML = nr.innerHTML.trim();
        console.log('wang complete!');
      }, 500);
    }
  } // }}}

  // 丁辰靈 {{{
  var scroll2img_ding = function() {
    imgs[i].scrollIntoView();
    console.log(i);
    if ( /^https?:/.test(imgs[i].src) || imgs[i].src.length == 0 ) {
      i++;
    }

    // *** image load complete ***
    if ( i >= imgs.length ) {
      clearInterval(h);
      setTimeout(function() {

        shrinkElement(nr);
        insertElements();

        nr.innerHTML = nr.innerHTML.trim();
        console.log('ding complete!');
      }, 1000);
    }
  } // }}}

  // 陳平 {{{
  var scroll2img_chen = function() {
    imgs[i].scrollIntoView();
    console.log(i);
    if ( /^https?:/.test(imgs[i].src) || imgs[i].src.length == 0 ) {
      i++;
    }

    // *** image load complete ***
    if ( i>0 && ( i >= imgs.length || imgs[i-1].src.includes('C4nuwNA'))) {
      clearInterval(h);

      anchor = imgs[i-1];
      console.log(anchor);
      while( anchor.parentElement != nr ) {
        anchor = anchor.parentElement;
      }
      anchor.remove();

      setTimeout(function() {
        shrinkElement(nr);
        insertElements();
        nr.innerHTML = nr.innerHTML.trim();
        console.log('chen ping complete!');
      }, 1000);
    }
  } // }}}

  // 劉潤 {{{
  var scroll2img_liu = function() {
    imgs[i].scrollIntoView();
    console.log(i);
    if ( /^https?:/.test(imgs[i].src) || imgs[i].src.length == 0 ) {
      i++;
    }

    // *** image load complete ***
      if (i > 0 &&( i >= imgs.length || imgs[i-1].src.includes('QuanwQJw'))) {
        clearInterval(h);
        var anchor = imgs[i-1].parentElement;
        while ( anchor.nextElementSibling != null ) {
          anchor.nextElementSibling.remove();
        }
        while ( anchor.previousElementSibling != null && anchor.previousElementSibling.tagName != 'HR' ) {
          anchor.previousElementSibling.remove();
        }
        if ( anchor.previousElementSibling != null ) {
          anchor.previousElementSibling.remove();
        } // */
        anchor.remove();

        anchor = xpath('//span[contains(text(),"丨作者 / 刘润")]')[0].parentElement;
        if ( anchor.nextElementSibling != null ) {
          anchor.nextElementSibling.remove();
        }
        anchor.remove();

        nr.firstElementChild.remove();
        nr.firstElementChild.remove();

        setTimeout(function() {
          shrinkElement(nr);
          insertElements();
          nr.innerHTML = nr.innerHTML.trim();
          console.log('liu complete!');
        }, 1000);
      }
  } // }}}

  // COMMON {{{
  var scroll2img = function() {
    imgs[i].scrollIntoView();
    console.log(i);
    if ( /^https?:/.test(imgs[i].src) || imgs[i].src.length == 0 ) {
      i++;
    }

    // *** image load complete ***
    // YFSDaA：李子暘
    if ( i > 0 && (i >= imgs.length || /bianw|YFSDaA|C4nuwNA/.test(imgs[i-1].src))) {
      clearInterval(h);
      setTimeout(function() {
        shrinkElement(nr);
        insertElements();
	    if (document.querySelector('#js_author_name').textContent == '李子旸') {
		  document.querySelector('#js_content > p:nth-of-type(2)').remove();
		  var ref_pos = document.querySelector('#org_url');
		  ref_pos.previousElementSibling.remove();
		  ref_pos.previousElementSibling.remove();

		  ref_pos.previousElementSibling.children[0].remove();
		  ref_pos.previousElementSibling.querySelector('img').remove();
		  ref_pos.previousElementSibling.querySelector('img').remove();
		  ref_pos.previousElementSibling.previousElementSibling.remove();/**/
		}
		  nr.innerHTML = nr.innerHTML.trim();
		  console.log('Normal mode complete!');
		}, 1000);
    }
  } // }}}
// }}}
// }}}

  // ***** START ***** {{{
  var discards = xpath('//span[count(*) = 0 and contains(text(),"点击上方")]')
  if ( discards.length > 0 ) {
    for ( i=0; i<discards.length; i++ ) {
      discards[i].remove();
    }
  }

  //setTimeout(eventFire, 1000,document.getElementById('publish_time'), 'click');
  setTimeout(weixin_init, 1000);
  nr = document.getElementById('js_content');
  author = document.querySelector('#meta_content').textContent;

  // load image
  imgs = nr.getElementsByTagName('img');
  if (imgs.length > 0 ) {
    if ( author.includes('全球风口') || author.includes('首席未来官') ) {
    //if ( /全球风口|首席未来官/.test(author) ) {
      h = setInterval(scroll2img_wang,200);
    } else if ( author.includes ('丁辰灵')) {
      h = setInterval(scroll2img_ding,200);
    } else if ( author.includes ('眉山剑客陈平')) {
      setTimeout(function() {
      	h = setInterval(scroll2img_chen,200);
      }, 1000);
    } else if ( author.includes ('刘润')) {
      setTimeout(function() {
        h = setInterval(scroll2img_liu,200);
      },2000);
    } else { // 李子旸 罗辑思维
      setTimeout(function() {
        h = setInterval(scroll2img,200);
      },2000);
    }
  } else {
    // Page without image
    shrinkElement(nr);
    insertElements();
  }

  // }}}
})();
// vim: fdm=marker sw=2
