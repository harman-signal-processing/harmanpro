// begin training_courses.js
$(function() {
    if (location.pathname === "/training/classroom-courses") {
        setTimeout(loadCourseCatalog, 100);
    }


    $(document.body).on('click', ".CourseHeader",
        function() {
            var $this = $(this),
                $courseContainer = $this.next(".CourseContainer"),
                $arrowImage = $this.children('img:first');

            $courseContainer.is(":visible") ? $courseContainer.hide("slow") : $courseContainer.show("slow");
            toggleArrowImage($arrowImage);

        }); // $(document.body).on('click', ".CourseHeader", function

    function loadCourseCatalog() {
        $("#CourseCostList").after("<div id='ClassroomCourseCatalogContainer' class='CourseCatalogContainer'><em>One moment, loading classroom course info . . .</em></div>");

        $.ajax({
            type: "GET",
            url: "/training/courses.json",
            data: "",
            contentType: "application/json; charset=utf-8",
            dataType: "json",

            success: function(dataFromServer, status, xmlhttp) {
                //var courseCategories = [];
                var courseListClassroom = [];

                $(dataFromServer.data.row).each(
                    function() {
                        var $this = $(this);


                        if ($this.attr('ows_Course_x0020_Type') == 'Instructor-Led') {
                            var course = {};
                            course.name = $this.attr('ows_LinkTitle');
                            course.category = $this.attr('ows_Course_x0020_Category');
                            course.type = $this.attr('ows_Course_x0020_Type');
                            //course.credits = $this.attr('ows_CEUS');
                            course.infocomm = $this.attr('ows_InfoCommUnits');
                            course.cedia = $this.attr('ows_CEDIA_Units');
                            //course.nsca = $this.attr('ows_NSCAUnits');
                            course.description = $this.attr('ows_courseDescription');
                            course.duration = $this.attr('ows_courseDuration');
                            course.flag = $this.attr('ows_courseFlag');
                            course.sortOrder = $this.attr('ows_Course_Sort_Order');

                            courseListClassroom.push(course);
                        }

                        ////////////////////////////////////////////
                        // END DATA LOOP
                        ///////////////////////////////////////////
                    }); //  $(dataFromServer.data.row).each



                ///////////////////////////////////////////
                // CLASSROOM COURSES
                ///////////////////////////////////////////

                var classroomCourseHtml = "";

                //Create Classroom Course array of course objects
                var coursesInClassroom = [];
                coursesInClassroom = jQuery.grep(courseListClassroom, function(courseObj, index) {
                    return courseObj.type == 'Instructor-Led';
                });

                //Sort the Classroom course objects
                coursesInClassroom.sort(function(courseObj1, courseObj2) {
                    return (parseFloat(courseObj1.sortOrder) < parseFloat(courseObj2.sortOrder)) ? -1 : (parseFloat(courseObj1.sortOrder) > parseFloat(courseObj2.sortOrder)) ? 1 : 0;
                });

                //Loop through the sorted Classroom course objects
                $.each(coursesInClassroom, function(index, courseObj) {
                    //console.log('obj.name : ' + courseObj.name);

                    var newIconLink = "";
                    //if (courseObj.flag.indexOf("NewIcon.png") != -1)
                    //{
                    //    newIconLink = "<img src='/images/new.png' class='newIcon' />";
                    //}

                    classroomCourseHtml += "<div class='stopTheToggleJumping'>" +
                        "<div class='CourseHeader' name='" + courseObj.name + "'><img src='/images/smallArrow-right.png' />" + courseObj.name + " " + newIconLink + "</div> <!--  End <div class='CourseHeader'> -->" +
                        "<div class='CourseContainer' style='display:none;'>" +
                        "<div class='stopTheToggleJumping'>" +
                        "<div class='CourseContentContainer'>" +
                        "<div class='CourseDesc'>" + courseObj.description + "</div><!-- End div class='CourseDesc'> -->" +
                        "<div class='CourseDuration'>Course Duration: " + courseObj.duration + " (hh:mm:ss)</div><!--  End <div class='CourseDuration'> -->" +
                        "<table>" +
                        "<tr>" +
                        "<td>InfoComm RUs:</td>" +
                        "<td width='25'></td>" +
                        "<td align='right'><span id='" + courseObj.name + "_infocomm'>" + courseObj.infocomm + "</span></td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td>CEDIA CEUs:</td>" +
                        "<td width='25'></td>" +
                        "<td align='right'><span id='" + courseObj.name + "_cedia'>" + courseObj.cedia + "</span></td>" +
                        "</tr>" +
                        "</table>" +
                        "</div> <!--  End <div class='CourseContentContainer'> -->" +
                        "</div> <!-- End <div class='stopTheToggleJumping'> -->" +
                        "</div> <!--  End <div class='CourseContainer'> -->" +
                        "</div> <!-- End <div class='stopTheToggleJumping'> -->" +
                        "";
                }); //jQuery.each(coursesInClassroom, function (index, courseObj)


                var $ClassroomCourseCatalogContainer = $("#ClassroomCourseCatalogContainer");
                $ClassroomCourseCatalogContainer.hide("slow").html("").finish().append(classroomCourseHtml).show("slow");

                //////////////////////////////////////////
                // END SUCCESS FUNCTION
                /////////////////////////////////////////
            }, // success: function (dataFromServer, status, xmlhttp)

            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $("#divEvents").html("Loading events ...");
                //setTimeout("loadTradeShowEvents()", 200);

                //alert('XMLHttpRequest.responseText:' + XMLHttpRequest.responseText + '\n XMLHttpRequest.responseXML:' + XMLHttpRequest.responseXML + '\n textStatus:' + textStatus + '\n' + 'errorThrown:' + errorThrown);

                var errorHtml = "XMLHttpRequest.responseText: " + XMLHttpRequest.responseText + "<br>" +
                    "XMLHttpRequest.responseXML: " + XMLHttpRequest.responseXML + "<br>" +
                    "textStatus: " + textStatus + "<br>" +
                    "errorThrown: " + errorThrown + "<br>";

                $("#divError").html(errorHtml);

                var stophere;
            }
        }); //$.ajax(
    } // function loadCourseCatalog()

    function toggleArrowImage($arrowImg) {
        //var $arrowImg = $(this).children('img:first');
        var downArrowSrc = $arrowImg.attr('src').replace('-right.png', '-down.png');
        var rightArrowSrc = $arrowImg.attr('src').replace('-down.png', '-right.png');

        //if right arrow showing
        if ($arrowImg.attr('src').indexOf('-down') == -1) {
            $arrowImg.attr('src', downArrowSrc);
        }
        else {
            $arrowImg.attr('src', rightArrowSrc);
        }
    } //  function toggleArrowImage($arrowImg)



}); //  $(function()
//  end training_courses.js
