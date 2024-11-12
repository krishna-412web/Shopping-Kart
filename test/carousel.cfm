<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Centered Carousel</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Define fixed dimensions for the carousel to prevent overflow */
        #carouselExample {
            width: 250px; /* Adjust the width as needed */
            height: 350px;
            overflow: hidden; /* Adjust the height as needed */ /* Hide any overflow */
        }
        
    </style>
</head>
<body>

<div class="container d-flex flex-row justify-content-center align-items-center" style="height: 85vh;">
    <div id="carouselExample" class="carousel slide" data-bs-ride="carousel">
        <!-- Carousel Items -->
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="../admin/images/iphone2.jpg" alt="First Slide" class="d-block w-100" style="object-fit: contain;">
            </div>
            <div class="carousel-item">
                <img src="../admin/images/naruto.jpeg" alt="Second Slide" class="d-block w-100">
            </div>
            <div class="carousel-item">
                <img src="../admin/images/iphone15.jpeg" alt="Third Slide" class="d-block w-100">
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
