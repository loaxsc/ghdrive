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

var h = setInterval(function() {
  //console.log( document.querySelector('script[src$="nc-loader-0.12.0.min.js"]').toString());
  if ( document.querySelector('script[src$="nc-loader-0.12.0.min.js"]') ) {
    console.info('video is ok');
    clearInterval(h);
    //var nr = document.createElement('p');
    //nr.textContent = document.querySelector('h1.video-title')['title'];
    //document.querySelector('div#viewbox_report').append(nr)
    //document.querySelector('h1').after(btn);
    document.querySelector('span.rank').after(btn);
  }
}, 300);

// vim: fdm=marker sw=2
