var btn = document.createElement('input');
btn.setAttribute('id','bilibili_btn');
btn.setAttribute('type','button');
btn.setAttribute('value','copy url');
btn.setAttribute('style','padding: 0 2px;');

var bilibili_btn_func = function(e) {
  var url = location.toString();
  var dt = document.querySelector('div.video-data > span:nth-of-type(3)')
				   .innerText.split(' ')[0].replaceAll('-','');
  var title = document.querySelector('span.tit').innerText;
  var text = '`' + dt + '`' + title + '`' + url + '`';
  navigator.clipboard.writeText(text).then(function() {
	  console.log('Async: Copying to clipboard was successful!');
  }, function(err) {
	  console.error('Async: Could not copy text: ', err);
  });
}
btn.addEventListener('click', bilibili_btn_func);
setTimeout(function() {
  document.querySelector('h1').after(btn);
}, 2000);
//rq.append(btn);

// vim: fdm=marker sw=2
