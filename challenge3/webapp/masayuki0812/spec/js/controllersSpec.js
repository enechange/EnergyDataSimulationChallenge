describe('Edsc3Controllers', function () {

    beforeEach(module('Edsc3Services'));
    beforeEach(module('Edsc3Controllers'));

    describe('HouseListCtrl', function () {
        var $scope, $ctrl;

        beforeEach(inject(function($controller, $rootScope) {
            $scope = $rootScope.$new()
            $ctrl = $controller('HouseListCtrl', {"$scope":$scope});
        }));

        it('should have open()', function () {
            expect(typeof $scope.open).toBe('function');
        });
        it('should have new()', function () {
            expect(typeof $scope.new).toBe('function');
        });

    });

});
