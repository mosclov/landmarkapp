// $("document").ready(function() {
//
//   $("#review_form").on(
//     "click",
//     function() {
//       // Data to be submitted
//       newReview = {
//         "review": {
//           "text": $("#review_text").val(),
//           "landmark_id": $("#review[landmark_id]").val()
//           "user_id": $("#review[user_id]").val()
//         }
//       }
//
//       $.ajax({
//         dataType: 'json',
//         url: '/landmarks/' + $("#review[landmark_id]").val(),
//         method: 'POST',
//         data: newReview,
//         success: function(dataFromServer) {
//           add_to_rev_list(dataFromServer);
//         },
//         error: function(jqXHR, textStatus, errorThrown) {
//           alert("Adding review failed: " + errorThrown);
//         }
//       });
//   });// end add wine
//
// }); // end document ready
//
// // Function to be called after data has been successfully submitted
// function add_to_rev_list(data) {
//   $("#wreview_list").append(
//     '<li><a href="' + '/wines/' + data.id + '">' +
//     data.text + "</a></li>");
// }
