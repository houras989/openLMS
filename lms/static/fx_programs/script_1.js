$(document).ready(function () {
    $.ajax({
        type: "GET",
        url: "http://studio.local.overhang.io:8001/fxprograms/api/programs",
        success: function (response) {
            console.log("response", response);

            var programs = response;
            console.log("programs", programs);

            let program_id = Object.keys(programs)[0];
            let program_name = programs[program_id].name;
            console.log("program_id", program_id);
            console.log("program_name", program_name);

            let metadata = programs[program_id].metadata;
            console.log("metadata", metadata);

            countItems(metadata);

            for (let course in metadata) {
                let courseData = metadata[course];

                const course_image_url = courseData.course_image_url || "";
                const course_name = courseData.display_name || "";
                const course_id = courseData.id || "";

                console.log("course_id", course_id);
                console.log("course_name", course_name);
                console.log("course_image_url", course_image_url);

                var card = `
                <div class="card">
                    <img src="${course_image_url}" class="card-img-top" style="padding: 15px; border-radius: 20px" />
                    <div class="card-body">
                        <h5 class="card-title">${course_name}</h5>
                    </div>
                    <div class="card-footer d-flex justify-content-between">
                        <p class="card-text">${program_id} - ${course_id}</p>
                        <a href="#" class="stretched-link">
                            <i class="fa fa-long-arrow-right" style="font-size: 20px; transform: scale(1.5)" aria-hidden="true"></i>
                        </a>
                    </div>
                </div>
                `;
                $(".card-deck").append(card);
            }
        },
    });
});

// Đếm số lượng item trong JSON
function countItems(data) {
    const programElement = document.getElementById("program_count");
    let programCount = Object.keys(data).length;
    return (programElement.innerHTML = programCount);
}