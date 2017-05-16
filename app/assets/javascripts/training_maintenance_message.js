$(function()
{
    var 
        now = new Date(),
        enddate = new Date('2017','4','21');  // <--- 5/21/2017
    if (now < enddate)
    {
        $(".training-top-content-row").prepend("<div style='background-color:red;color:white;text-align:center;'>Note: Harman Pro University will be down for scheduled maintenance from Saturday May 20, 2017 8:00 am (CST) – Sunday May 21, 2017 4:00 am (CST).</div>");
    }
});  //  $(function()