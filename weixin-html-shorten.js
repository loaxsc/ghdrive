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
	  var text = '`' + dt + '`' + title + '`' + url + '`';
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

  document.querySelectorAll('a').forEach((a) => {
	if (/mp\.weixin\.qq\.com\/s\?__biz=\w+==&mid=\d+&idx=\d&sn=\w+/.test(a.href) ) {
	  a.href = a.href.replace(/&(chksm|scene).+/,'');
	}
  });
},1000);
