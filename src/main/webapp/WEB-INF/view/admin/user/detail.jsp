<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

            <div class="modal fade" id="detailModal${user.id}" tabindex="-1"
                aria-labelledby="detailModalLabel${user.id}" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-lg">
                    <div class="modal-content border-0 shadow-lg rounded-4 overflow-hidden">

                        <div class="modal-header bg-gradient-primary text-white">
                            <h5 class="modal-title fw-bold" id="detailModalLabel${user.id}">
                                <i class="bi bi-person-vcard me-2"></i> User Details
                            </h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>

                        <div class="modal-body p-4">
                            <h4 class="text-dark fw-bold mb-4 text-center">${user.fullName}</h4>

                            <div class="card border-0 shadow-sm rounded-3">
                                <div class="card-header bg-light p-3 text-center">
                                    <img src="/images/avatar/${user.image}" alt="Avatar"
                                        class="rounded-circle shadow-sm border border-3 p-1"
                                        style="width: 140px; height: 140px; object-fit: cover; border-color:#ffba00;">
                                    <div class="mt-2 small text-muted">ID: ${user.id}</div>
                                    <span
                                        class="badge mt-2 px-3 py-1 fw-normal bg-gradient-primary">${user.role.name}</span>
                                </div>

                                <div class="card-body px-4">
                                    <h6 class="fw-semibold mb-3 border-bottom pb-2">
                                        <i class="bi bi-info-circle me-1"></i> Account Information
                                    </h6>

                                    <div class="row mb-3">
                                        <div class="col-md-6 mb-2">
                                            <strong><i class="bi bi-person-circle me-1"></i> Username:</strong>
                                            <div class="text-muted">@${user.username}</div>
                                        </div>
                                        <div class="col-md-6 mb-2">
                                            <strong><i class="bi bi-envelope me-1"></i>Email:</strong>
                                            <div class="text-muted">${user.email}</div>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-md-6 mb-2">
                                            <strong><i class="bi bi-telephone me-1"></i> Phone:</strong>
                                            <div class="text-muted">${user.phoneNumber}</div>
                                        </div>
                                        <div class="col-md-6 mb-2">
                                            <strong><i class="bi bi-geo-alt me-1"></i> Address:</strong>
                                            <div class="text-muted">${user.address}</div>
                                        </div>
                                    </div>

                                </div>
                            </div>

                        </div>

                        <div class="modal-footer border-0">
                            <button type="button" class="btn bg-gradient-primary" data-bs-dismiss="modal">
                                Close
                            </button>
                        </div>

                    </div>
                </div>
            </div>