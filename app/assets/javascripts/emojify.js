$(function() {
  emojify.setConfig({
    emojify_tag_type : '.entry',
    img_dir: '/emoji',
    ignored_tags: {
      'SCRIPT'  : 1,
      'TEXTAREA': 1,
      'A'       : 0,
      'PRE'     : 1,
      'CODE'    : 1
    }
  });
  emojify.run();
});
