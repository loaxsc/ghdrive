var btn = document.createElement('input');
btn.setAttribute('id','bilibili_btn');
btn.setAttribute('type','button');
btn.setAttribute('value','copy url');
// stylish
//btn.setAttribute('style','padding: 0 2px; margin: 0 2px; color: #666;');

var bilibili_btn_func = function(e) {
  var url = location.toString()
                    .replace(/\?.+$/, '');
  var dt = document.querySelector('div.video-data > span:nth-of-type(3)')
           .innerText.split(' ')[0].replaceAll('-','');
  var title = document.querySelector('span.tit').innerText
                      .replace(/【武志红】$/g,'')
                      .replace(/^【眉山論劍】/g,'')
                      .replace(/^温铁军：|【温铁军践闻录.*】$/g,'');
  var text = '`' + title + '`' + url + '`' + dt + '`';
  //var text = `\`${title}\`${url}\`${dt}\``
  navigator.clipboard.writeText(text).then(function() {
    console.log('Async: Copying to clipboard was successful!');
  }, function(err) {
    console.error('Async: Could not copy text: ', err);
  });
}
btn.addEventListener('click', bilibili_btn_func);

var btn_effect = function(btn_id) {
  var btn_style = document.createElement('style');
  btn_style.setAttribute('id', btn_id + '_effect');
  btn_style.innerHTML = '#' + btn_id //+ ' { box-shadow: 2px 2px rgba(131, 204, 234, 0.5); }';
    + ' { border: 2px solid skyblue; border-radius: 3px; }';
  document.body.appendChild(btn_style);
  console.log('function on');

  setTimeout(function() {
      document.body.removeChild(btn_style);
  }, 500);
}

// Hotkeys, Shortcuts
window.top.addEventListener('keydown', (e) => {
  if (!e.shiftKey && !e.ctrlKey && e.altKey && e.code == 'Digit0') {
    e.preventDefault();
    bilibili_btn_func(e);
    btn_effect('bilibili_btn');
  }
  /*if ( e.shiftKey && e.altKey && e.code == 'Digit0' ) {
    e.preventDefault();
    weixin_btn_nr_func(e);
  } /**/
});

var h = setInterval(function() {
  //if ( document.querySelector('script[src$="nc-loader-0.12.0.min.js"]') ) {
  if ( document.querySelector('button.bilibili-player-iconfont') ) {
    console.info('video is ok');
    clearInterval(h);
    document.querySelector('div.video-data').append(btn);
  }
}, 300);/**/

// vim: fdm=marker sw=2
