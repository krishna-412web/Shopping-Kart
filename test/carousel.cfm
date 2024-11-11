<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confined Carousel</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Define fixed dimensions for the carousel to prevent overflow */
        #carouselExample {
            width: 350px; /* Adjust the width as needed */
            height: 400px; /* Adjust the height as needed *//* Hide any overflow */
        }
        /* Ensure carousel images fit within the defined area */
        .carousel-inner img {
            width: 80%;
            height: 60%;
            
/* Ensures images fill the area without overflow */
        }
    </style>
</head>
<body>

<div class="container d-flex flex-row justify-content-center align-items-center" style="height: 100vh;">
    <div id="carouselExample" class="carousel slide" data-bs-ride="carousel">
        <!-- Carousel Items -->
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="../images/background.jpeg" alt="First Slide">
            </div>
            <div class="carousel-item">
                <img src="../admin/images/naruto.jpeg" alt="Second Slide">
            </div>
            <div class="carousel-item">
                <img src="../admin/images/iphone15.jpeg" alt="Third Slide">
            </div>
        </div>

        <!-- Controls -->
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
