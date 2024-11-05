<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Address Modal</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<!-- Trigger Button for Address Modal -->
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addressModal">
    Choose Address
</button>

<!-- Address Selection Modal -->
<div class="modal fade" id="addressModal" tabindex="-1" aria-labelledby="addressModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addressModalLabel">Select an Address</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container">
                    <!-- Address List -->
                    <div class="d-flex flex-column">
                        <!-- Example Address 1 -->
                        <div>
                            <div class="card">
                                <div class="card-body">
                                    <h6 class="card-title">John Doe</h6>
                                    <p class="card-text">
                                        1234 Elm Street<br>
                                        Springfield, IL 62701<br>
                                        United States
                                    </p>
                                    <button class="btn btn-primary" onclick="selectAddress('1234 Elm Street, Springfield, IL 62701')">Select</button>
                                    <button class="btn btn-link">Edit</button>
                                </div>
                            </div>
                        </div>
                        <!-- Example Address 2 -->
                        <div>
                            <div class="card">
                                <div class="card-body">
                                    <h6 class="card-title">Jane Smith</h6>
                                    <p class="card-text">
                                        5678 Oak Avenue<br>
                                        Anytown, CA 90210<br>
                                        United States
                                    </p>
                                    <button class="btn btn-primary" onclick="selectAddress('5678 Oak Avenue, Anytown, CA 90210')">Select</button>
                                    <button class="btn btn-link">Edit</button>
                                </div>
                            </div>
                        </div>
                        <!-- Add More Address Cards Here -->
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-success" onclick="addNewAddress()">Add New Address</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript for Bootstrap & Address Selection -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script>
    function selectAddress(address) {
        alert("Address selected: " + address);
        // Close the modal after selecting an address
        var addressModal = bootstrap.Modal.getInstance(document.getElementById("addressModal"));
        addressModal.hide();
    }

    function addNewAddress() {
        alert("Redirect to Add New Address page or open an add-address modal.");
        // Logic for adding a new address (e.g., redirect to another page or open a new modal)
    }
</script>

</body>
</html>