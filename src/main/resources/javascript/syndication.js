window.Jahia = window.Jahia || {};

Jahia.Syndication = function(options) {

    var Ajax = {
        /**
         * Use the right AJAX object type depending on the browser
         * @function
         * @private
         */
        x: function () {
            try {
                return new ActiveXObject('Msxml2.XMLHTTP');
            } catch (e1) {
                try {
                    return new ActiveXObject('Microsoft.XMLHTTP');
                } catch (e2) {
                    return new XMLHttpRequest();
                }
            }
        },

        /**
         *
         * @param {string} url URL to send the request
         * @param {function} callback Callback to process onSuccess
         * @param {string} method POST/GET
         * @param {JSON} data Data to send
         * @param {boolean} sync
         * @function
         * @private
         */
        send: function (url, callback, method, data, sync) {
            var x = this.x();
            x.open(method, url, sync);
            x.onreadystatechange = function () {
                if (x.readyState == 4) {
                    callback(x.responseText);
                }
            };
            if (method == 'POST') {

                x.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
            }
            x.setRequestHeader('Access-Control-Request-Method', 'GET');
            x.send(data);
        },

        /**
         * Ajax GET method, all the parameters in data are add to the URL query string.
         * @param {String} url URL to send the request
         * @param {JSON} data Data to send
         * @param {function} callback Callback to process onSuccess
         * @param {boolean} sync
         * @function
         */
        doGet: function (url, data, callback, sync) {
            var query = [];
            for (var key in data) {
                query.push(encodeURIComponent(key) + '=' + encodeURIComponent(data[key]));
            }
            this.send(url + '?' + query.join('&'), callback, 'GET', null, sync);
        },

        /**
         * Ajax POST method, all the parameters in data are send in the request
         * @param {String} url URL to send the request
         * @param {JSON} data Data to send
         * @param {function} callback Callback to process onSuccess
         * @param {boolean} sync
         * @function
         */
        doPost: function (url, data, callback, sync) {
            var query = [];
            for (var key in data) {
                query.push(encodeURIComponent(key) + '=' + encodeURIComponent(data[key]));
            }
            this.send(url, callback, 'POST', query.join('&'), sync);
        }
    };

    options = options || {};

    var id = options.id || 'Jahia_syndication' + (Math.ceil(Math.random() * (new Date).getTime()));
    var height = options.height || '100%';
    var url = options.url || 'http://www.jahia.com/fr/home/download/forum.html';
    var width = options.width || '100%';

    if(options.noFrame){
        Ajax.doGet(url, null, function(html){
            document.write(html);
        }, false);
    }else {
        var html = '<iframe frameborder="0" height="' + height + '" id="' + id + '" src="' + url + '" width="' + width + '"></iframe>';
        document.write(html);
    }


};