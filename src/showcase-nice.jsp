<%-- 
    showcase.jsp
    
    @version $Date: 2012-10-19 20:49:39 +0200 (Fri, 19 Oct 2012) $ $Id: showcase.jsp 1400220 2012-10-19 18:49:39Z jogep $
--%>

<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Bryce Product Annoucement</title>

    <!-- Bootstrap core CSS -->
    <link href="https://bryce-assets.s3-ap-southeast-1.amazonaws.com/grapefruit/vendor/bootstrap/css/bootstrap.min.css"
        rel="stylesheet">

    <!-- Custom fonts for this template -->
    <link
        href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:200,200i,300,300i,400,400i,600,600i,700,700i,900,900i"
        rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Merriweather:300,300i,400,400i,700,700i,900,900i"
        rel="stylesheet">
    <link href="https://bryce-assets.s3-ap-southeast-1.amazonaws.com/grapefruit/vendor/fontawesome-free/css/all.min.css"
        rel="stylesheet" type="text/css">

    <!-- Custom styles for this template -->
    <link href="https://bryce-assets.s3-ap-southeast-1.amazonaws.com/grapefruit/css/coming-soon.min.css"
        rel="stylesheet">

</head>

<body>

    <div class="overlay"></div>
    <video playsinline="playsinline" autoplay="autoplay" muted="muted" loop="loop">
        <source src="https://bryce-assets.s3-ap-southeast-1.amazonaws.com/grapefruit/mp4/bg.mp4" type="video/mp4">
    </video>

    <div class="masthead">
        <div class="masthead-bg"></div>
        <div class="container h-100">
            <div class="row h-100">
                <div class="col-12 my-auto">
                    <div class="masthead-content text-white py-5 py-md-0">
                        <h1 class="mb-3">Coming Soon!</h1>
                        <p class="mb-5">We're working hard to finish the development of this site. Our target launch
                            date is
                            <strong>January 2019</strong>! Sign up for updates using the form below!</p>
                        <div class="input-group input-group-newsletter">
                            <input type="email" class="form-control" placeholder="Enter email..."
                                aria-label="Enter email..." aria-describedby="basic-addon">
                            <div class="input-group-append">
                                <button class="btn btn-secondary" type="button">Notify Me!</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <!-- Bootstrap core JavaScript -->
    <script src="https://bryce-assets.s3-ap-southeast-1.amazonaws.com/grapefruit/vendor/jquery/jquery.min.js"></script>
    <script
        src="https://bryce-assets.s3-ap-southeast-1.amazonaws.com/grapefruit/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Custom scripts for this template -->
    <script src="https://bryce-assets.s3-ap-southeast-1.amazonaws.com/grapefruit/js/coming-soon.min.js"></script>

</body>

</html>