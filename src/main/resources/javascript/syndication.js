window.Jahia = window.Jahia || {};

Jahia.Syndication = function(options) {
    options = options || {};

    var id = options.id || 'Jahia_syndication' + (Math.ceil(Math.random() * (new Date).getTime()));
    var height = options.height || '100%';
    var url = options.url || 'http://www.jahia.com/fr/home/download/forum.html';
    var width = options.width || '100%';

    var html = '<iframe frameborder="0" height="' + height + '" id="' + id + '" src="' + url + '" width="' + width + '"></iframe>';

    document.write(html);
};