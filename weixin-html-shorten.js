var nr = document.querySelector('#js_content');

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


setTimeout(function() {
  var eventFire = function(el, etype) {
	if (el.fireEvent) {
	  el.fireEvent('on' + etype);
	} else {
	  var evObj = document.createEvent('Events');
	  evObj.initEvent(etype, true, false);
	  el.dispatchEvent(evObj);
	}
  }
  eventFire(document.getElementById('publish_time'),'click');

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
	  var text = '`' + title + '`' + url + '`' + dt + '`';
	  navigator.clipboard.writeText(text).then(function() {
		  console.log('Async: Copying to clipboard was successful!');
	  }, function(err) {
		  console.error('Async: Could not copy text: ', err);
	  });
  }
  btn.addEventListener('click', weixin_btn_func);
  rq.append(btn);


  var btn = document.createElement('input');
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

  var btn_effect = function (btn_id) {
    var btn_style = document.createElement('style');
    btn_style.setAttribute('id', btn_id);
    btn_style.innerHTML = '#' + btn_id + ' { box-shadow: 2px 2px rgba(131, 204, 234, 0.5); }';
    document.body.appendChild(btn_style);

    setTimeout(() => {
        document.body.removeChild(btn_style);
    }, 500);
  }

  // Hotkeys, Shortcuts
  window.top.addEventListener('keydown', (e) => {
    if (e.altKey && e.code == 'Digit0') {
      e.preventDefault();
      weixin_btn_func(e);
      btn_effect_btn_url();
    }
    if ( e.shiftKey && e.altKey && e.code == 'Digit0' ) {
      e.preventDefault();
      weixin_btn_nr_func(e);
    }
  });

  document.querySelectorAll('a').forEach((a) => {
	if (/mp\.weixin\.qq\.com\/s\?__biz=\w+==&mid=\d+&idx=\d&sn=\w+/.test(a.href) ) {
	  a.href = a.href.replace(/&(chksm|scene|source).+/,'');
	}
  });

  //shrinkElement(nr);
  insertElements();
},1000);

// vim: fdm=marker sw=2
