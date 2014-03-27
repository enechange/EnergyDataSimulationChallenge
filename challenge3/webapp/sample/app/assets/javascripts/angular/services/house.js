var app = angular.module('CambridgeApp');

app.factory('House', function($resource) {
  // TODO(sungho.arai): Use $resource to get houses data
  return [
        {"name": "nakamura", "point": "10"},
        {"name": "hoge", "point": "20"},
        {"name": "ugaugo", "point": "200"},
    ];
});
