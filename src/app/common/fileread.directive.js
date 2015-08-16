angular.module('door').directive("filearea", [function () {
    return {
        restrict: 'AE',
        template: '<div><input name="name" as="file" type="file" fileread=""><img id="preview" src="{{imgPath}}" alt="上传的图片" width="120"/></div>',
        scope: {
            fileread: "=",
            name: "@"
        },
        link: function (scope, element, attributes) {
            element.bind("change", function (changeEvent) {
                if(changeEvent.target.files.length <= 0) return;

                file = changeEvent.target.files[0]
                var reader = new FileReader();
                reader.onload = function (loadEvent) {
                    scope.$apply(function () {
                        scope.imgPath = loadEvent.target.result;
                        scope.fileread = loadEvent.target.result;
                    });
                }
                reader.readAsDataURL(file);
            });
        }
    }
}]);


// .directive("fileread", [function () {
//     return {
//         scope: {
//             fileread: "="
//         },
//         link: function (scope, element, attributes) {
//             element.bind("change", function (changeEvent) {
//                 scope.$apply(function () {
//                     scope.fileread = changeEvent.target.files[0];
//                     // or all selected files:
//                     // scope.fileread = changeEvent.target.files;
//                 });
//             });
//         }
//     }
// }]);


// .directive("fileread", function () {
//     return {
//       scope: {
//         fileread: "="
//       },
//       link: function (scope, element, attributes) {
//         element.bind("change", function (changeEvent) {
//           var readers = [] ,
//               files = changeEvent.target.files ,
//               datas = [] ;
//           for ( var i = 0 ; i < files.length ; i++ ) {
//             readers[ i ] = new FileReader();
//             readers[ i ].onload = function (loadEvent) {
//               datas.push( loadEvent.target.result );
//               if ( datas.length === files.length ){
//                 scope.$apply(function () {
//                   scope.fileread = datas;
//                 });
//               }
//             }
//             readers[ i ].readAsDataURL( files[i] );
//           }
//         });

//       }
//     }
//   });