// $(document).ready(function()  {
//     getlists()
// })
//
// function getlists() {
//     const data = {
//         page: 1,
//         pageSize: 9
//     }
//     $.ajax({
//         url: "/study/getstudylist",
//         type: "get",
//         data : data,
//         dataType: "json",
//         accept: "application/json",
//         success: function(studys) {
//             ${'#formBody'}.html(
//                 '총갯수:' + studys.total);
//             let html ='';
//             let list = studys.list;
//             for(const idx in studys){
//                 console.log(idx);
//             }
//         },
//         error: function(errorThrown) {
//             alert(errorThrown.statusText);
//         }
//     });
// }
//

