var htd = {}; // harman training data
htd.allcourselist = [];
htd.allcourselistwithcountry = [];
htd.allcourselistwithNOcountry = [];
htd.countrylist = [];
htd.getbycountry = {};

$(function ()
{

    var getdata = function getdata()
    {
        var today = new Date(); //Today's Date
        var toDate = new Date(today.getFullYear()+1, today.getMonth(), today.getDate());

        var dataToSend = {
            fromDate: today.getMonth()+1 + "-" + today.getDate() + "-" + today.getFullYear(),
            toDate: toDate.getMonth()+1 + "-" + toDate.getDate() + "-" + toDate.getFullYear(),
            resultFormat: "JSON"
        };
        var ajaxRequest =
                    $.ajax(
                            {
                                type: "GET",
                                url: "/training/calendar.json",

                                //sending json data
                                //data: dataToSend,
                                data: JSON.stringify(dataToSend),

                                //contentType = type sent to server
                                contentType: "application/json; charset=utf-8",

                                //dataType = help jquery know what type to expect to get back from the server
                                dataType: "json",
                                //dataType: "jsonp",

                                success: function (dataFromServer, status, xmlhttp)
                                {
                                    //everything is handled by the caller
                                },
                                error: function (XMLHttpRequest, textStatus, errorThrown)
                                {
                                    //everything is handled by the caller
                                }

                            });     //$.ajax(

        return ajaxRequest;
    };  //  var getdata = function getdata()

    showData();

    function showData()
    {
        var results = getdata();
        //cleardisplaylist();

        results.done(
            
            function (dataFromServer, status, xmlhttp)
            {

                $.each(dataFromServer["training_calendar"], function (index, value)
                {
                    

                    htd.allcourselist.push(value);

                    // add the country to the list if the value exist and is not already in the list
                    if (typeof value.VenueCountry != "undefined")
                    {
                        if ($.inArray(value.VenueCountry, htd.countrylist) === -1)
                        {
                            htd.countrylist.push(value.VenueCountry);

                            //add new object into getbycountry
                            htd.getbycountry[value.VenueCountry] = [];
                            htd.getbycountry[value.VenueCountry].push(value);

                        }  //  if(!!$.inArray(value.VenueCountry, htd.countrylist))
                        else
                        {
                            htd.getbycountry[value.VenueCountry].push(value);
                        }

                        htd.allcourselistwithcountry.push(value);

                        //showCourseInfo(value);

                    }  //  if (typeof value.VenueCountry != "undefined")
                    else
                    {
                        htd.allcourselistwithNOcountry.push(value);
                    }
                    

                });  //  $.each(data, function ()
                
                //buildCountryListLinks();
                //$("#country-list").show("slow");
                $(".choosen-value").html("ALL  " + htd.allcourselistwithcountry.length + "");
                //$("#country-choosen").show("slow");
                $("#loadMessage").hide("slow");

            }); //results.done

        results.fail(
            function (XMLHttpRequest, textStatus, errorThrown)
            {
                var errorHtml = "<div>XMLHttpRequest.responseText: " + XMLHttpRequest.responseText + "<br>" +
                "XMLHttpRequest.responseXML: " + XMLHttpRequest.responseXML + "<br>" +
                "textStatus: " + textStatus + "<br>" +
                "errorThrown: " + errorThrown + "</div>";

                //$("#divError").html(errorHtml);
                $('body').append(errorHtml);
            }); //results.fail

    }  //  function showData()

    function showCourseInfo(courseInfo)
    {
        var $table = $("#calendar-table");

        var $div = $('<div />', { class: 'courserow' }).appendTo($table);

        var RemainingSeats = parseInt(courseInfo.RemainingSeats),
        RemainingSeatsMessage = RemainingSeats > 0 ? "Seats Available" : "No Seats Available",
        RemainingSeatsCssClass = RemainingSeats > 0 ? "seatsAvailable" : "noSeatsAvailable";

        //EnrollmentURL

        var html = "<div class='course-info-attribute sessionName'><strong>" + courseInfo.SessionName + "</strong>" +
            "<br /><span class='"+RemainingSeatsCssClass+"'>"+RemainingSeatsMessage+"</span></div>" +
            "<div class='course-info-attribute courseName'><strong>" + courseInfo.CourseName + "</strong><br />" +
                "<div class='linkButton'>"+courseInfo.CourseDescription+"</div>" +
                "<div class='linkButton'><a href='"+ courseInfo.EnrollmentURL +"' target='_blank'>Start Here</a></div>" +
            "</div>" +


        "<div style='clear:both;'></div>" +
        "";

        $div.html(html);

    }  //  function showCourseInfo(courseInfo)

    function cleardisplaylist()
    {
        $("#calendar-table").html("");
    }//  function cleardisplaylist()

    function buildCountryListLinks()
    {
        var $countryListLinksContainer = $("#country-list");
        $countryListLinksContainer.append("<a href='#' class='country-link'>All</a>  "+ htd.allcourselistwithcountry.length + " | ");
        var count = 0;
        $.each(htd.countrylist.sort(), function (index, value)
        {
            // if last country don't add pipe
            if (htd.countrylist.length-1 == count)
            {
                $countryListLinksContainer.append("<a href='#' class='country-link'>" + value + "</a>  " + htd.getbycountry[value].length);
            }
            else
            {
                $countryListLinksContainer.append("<a href='#' class='country-link'>" + value + "</a>  " + htd.getbycountry[value].length + " | ");
            }
            count++;
        });  //  $.each(htd.countrylist, function (index, value)

    }//  function buildCountryListLinks()

    // user clicking country link
    $(document).on("click","a.country-link", function (e)
    {
        e.preventDefault();
        var country = $(this).text();

        $("#h-country-choosen").val(country);

        $("#calendar-table").hide("slow", function ()
        {
            cleardisplaylist();
            
            var courseCount = 0;

            if (country === "All")
            {
                courseCount = htd.allcourselistwithcountry.length;
                showCourseInfoByList(htd.allcourselistwithcountry);
            }
            else
            {
                courseCount = htd.getbycountry[country].length;
                showCourseInfoByList(htd.getbycountry[country]);
            }

            $(".choosen-value").html(country + " ("+courseCount+")");
            $("#calendar-table").show("slow");

        });  //  $("#calendar-table").hide("slow", function ()

        console.log(country);
    });  //  $("a.country-link").on("click", function ()

    $(document).on("click", "a.sort-link", function (e)
    {
        e.preventDefault();
        var $this = $(this);
        var sortItem = $this.text(),
            sortDirection = $this.data("sortDirection"),
            country = $("#h-country-choosen").val(),
            courseList = [];

        switch (sortItem + "-" + sortDirection)
        {
            case "Date-asc":
                if (country == "All")
                {
                    courseList = htd.allcourselistwithcountry.sort(sortCourseStartAsc);
                }
                else
                {
                    courseList = htd.getbycountry[country].sort(sortCourseStartAsc);
                }
                
                break;
            case "Date-desc":
                if (country == "All")
                {
                    courseList = htd.allcourselistwithcountry.sort(sortCourseStartDesc);
                }
                else
                {
                    courseList = htd.getbycountry[country].sort(sortCourseStartDesc);
                }
                
                break;
            case "Course-asc":
                if (country == "All")
                {
                    courseList = htd.allcourselistwithcountry.sort(sortCourseNameAsc);
                }
                else
                {
                    courseList = htd.getbycountry[country].sort(sortCourseNameAsc);  
                }
                
                break;
            case "Course-desc":
                if (country == "All")
                {
                    courseList = htd.allcourselistwithcountry.sort(sortCourseNameDesc);
                }
                else
                {
                    courseList = htd.getbycountry[country].sort(sortCourseNameDesc);  
                }
                
                break;

            case "Location-asc":
                if (country == "All")
                {
                    courseList = htd.allcourselistwithcountry.sort(sortVenueLocationAsc);
                }
                else
                {
                    courseList = htd.getbycountry[country].sort(sortVenueLocationAsc);  
                }
                
                break;
            case "Location-desc":
                if (country == "All")
                {
                    courseList = htd.allcourselistwithcountry.sort(sortVenueLocationDesc);
                }
                else
                {
                    courseList = htd.getbycountry[country].sort(sortVenueLocationDesc);  
                }
                
                break;                

        }  //  switch (sortItem)

        // toggle the sort order and store it
        sortDirection == "asc" ? $this.data("sortDirection", "desc") : $this.data("sortDirection", "asc");

        $("#calendar-table").hide("slow", function ()
        {
            cleardisplaylist();
            showCourseInfoByList(courseList);
            $("#calendar-table").show("slow");
        });  //  $("#calendar-table").hide("slow", function ()

    });  //  $(document).on("click", "a.sort-link", function (e)

    $(document).on("click", ".coursedescriptionlink", function (e)
    {


    });


    function showCourseInfoByList(listOfCourses)
    {
        $.each(listOfCourses, function (index, value)
        {
            showCourseInfo(value);
            //console.log("-"+value.CourseName+"-");
        });  //  $.each(listOfCourses, function (index, value)

    }  //  function showCourseInfoByList(listOfCourses)

    function sortCourseNameAsc(a, b)
    {
        var nameA = a.CourseName.toUpperCase(); // ignore upper and lowercase
        var nameB = b.CourseName.toUpperCase(); // ignore upper and lowercase
        if (nameA < nameB)
        {
            return -1;
        }
        if (nameA > nameB)
        {
            return 1;
        }

        // sort by date if course names are equal
        return sortCourseStartAsc(a, b);
    }  //  function sortCourseNameAsc(a, b)
    function sortCourseNameDesc(a, b)
    {
        var nameA = a.CourseName.toUpperCase(); // ignore upper and lowercase
        var nameB = b.CourseName.toUpperCase(); // ignore upper and lowercase
        if (nameA > nameB)
        {
            return -1;
        }
        if (nameA < nameB)
        {
            return 1;
        }

        // sort by date if course names are equal
        return sortCourseStartAsc(a, b);
    }  //  function sortCourseNameDesc(a, b)

    function sortVenueLocationAsc(a, b)
    {
        var nameA = a.VenueName.toUpperCase(); // ignore upper and lowercase
        var nameB = b.VenueName.toUpperCase(); // ignore upper and lowercase
        if (nameA < nameB)
        {
            return -1;
        }
        if (nameA > nameB)
        {
            return 1;
        }

        // sort by date if locations are equal
        return sortCourseStartAsc(a, b);
    }  //  function sortVenueLocationAsc(a, b)
    function sortVenueLocationDesc(a, b)
    {
        var nameA = a.VenueName.toUpperCase(); // ignore upper and lowercase
        var nameB = b.VenueName.toUpperCase(); // ignore upper and lowercase
        if (nameA > nameB)
        {
            return -1;
        }
        if (nameA < nameB)
        {
            return 1;
        }

        // sort by date if locations are equal
        return sortCourseStartAsc(a, b);
    }  //  function sortVenueLocationDesc(a, b)

    function sortCourseStartAsc(a, b)
    {
        return Math.sign(new Date(a.StartDate) - new Date(b.StartDate));
    }  //  function sortCourseStartAsc(a, b)
    function sortCourseStartDesc(a, b)
    {
        return Math.sign(new Date(b.StartDate) - new Date(a.StartDate));
    }  //  function sortCourseStartDesc(a, b)

    //  Math.sign Polyfill for stupid IE
    if (!Math.sign) 
    {
        Math.sign = function(x) 
        {
            // If x is NaN, the result is NaN.
            // If x is -0, the result is -0.
            // If x is +0, the result is +0.
            // If x is negative and not -0, the result is -1.
            // If x is positive and not +0, the result is +1.
            x = +x; // convert to a number
            if (x === 0 || isNaN(x)) {
            return Number(x);
            }
            return x > 0 ? 1 : -1;
        };
    }

});  //  $(function ()

