tinyMCE.init({
  selector: 'textarea.mceEditor',
  browsers: "msie,gecko,safari",
  cleanup: true,
  cleanup_on_startup: true,
  convert_fonts_to_spans: true,
  convert_urls: false,
  entities: '160,nbsp,38,amp,34,quot,162,cent,8364,euro,163,pound,165,yen,169,copy,174,reg,8482,trade,8240,permil,60,lt,62,gt,8804,le,8805,ge,176,deg,8722,minus',
  entity_encoding: 'named',
  valid_elements: '+*[*]',
//  extended_valid_elements: 'img[class|src|flashvars|border=0|alt|title|hspace|vspace|width|height|align|onmouseover|onmouseout|name|obj|param|embed|scale|wmode|salign|style|usemap],map[name|id],area[shape|coords|href|alt|name|id],embed[src|quality|scale|salign|wmode|bgcolor|width|height|name|align|type|pluginspage|flashvars],object[align<bottom?left?middle?right?top|archive|border|class|classid|codebase|codetype|data|declare|dir<ltr?rtl|height|hspace|id|lang|name|style|tabindex|title|type|usemap|vspace|width],iframe[src|title|width|height|allowfullscreen|frameborder|style]',
  language: 'en',
//  mode: 'textareas',
  plugins: "advlist,anchor,autolink,autoresize,colorpicker,code,hr,image,link,lists,media,searchreplace,spellchecker,textcolor,table,paste,preview",
  relative_urls: false,
  verify_html: false,
  setup: function (editor) {
      editor.on('change', function () {
          editor.save();
      });
  }
});
tinyMCE.init({
  browsers: "msie,gecko,safari",
  selector: 'textarea.mceEditorFP',
  cleanup: true,
  cleanup_on_startup: true,
  convert_fonts_to_spans: true,
  convert_urls: false,
  entities: '160,nbsp,38,amp,34,quot,162,cent,8364,euro,163,pound,165,yen,169,copy,174,reg,8482,trade,8240,permil,60,lt,62,gt,8804,le,8805,ge,176,deg,8722,minus',
  entity_encoding: 'named',
  valid_elements: '+*[*]',
//  extended_valid_elements: 'img[class|src|flashvars|border=0|alt|title|hspace|vspace|width|height|align|onmouseover|onmouseout|name|obj|param|embed|scale|wmode|salign|style|usemap],map[name|id],area[shape|coords|href|alt|name|id],embed[src|quality|scale|salign|wmode|bgcolor|width|height|name|align|type|pluginspage|flashvars],object[align<bottom?left?middle?right?top|archive|border|class|classid|codebase|codetype|data|declare|dir<ltr?rtl|height|hspace|id|lang|name|style|tabindex|title|type|usemap|vspace|width],iframe[src|title|width|height|allowfullscreen|frameborder|style]',
  language: 'en',
//  mode: 'textareas',
  plugins: "advlist,anchor,autolink,autoresize,colorpicker,code,hr,image,link,lists,media,searchreplace,spellchecker,textcolor,table,paste,preview,fullpage,fullscreen",
  relative_urls: false,
  verify_html: false,
  setup: function (editor) {
      editor.on('change', function () {
          editor.save();
      });
  }
});
