var currentSlide = 1;
var totalSlides = 21;

function showSlide(n) {
    var slides = document.querySelectorAll('.slide');
    var i;
    for (i = 0; i < slides.length; i++) {
        slides[i].classList.remove('active');
    }

    if (n > totalSlides) currentSlide = 1;
    if (n < 1) currentSlide = totalSlides;

    var activeSlide = document.querySelector('[data-slide="' + currentSlide + '"]');
    if (activeSlide) {
        activeSlide.classList.add('active');
    }

    updateCounter();
    updateProgress();
}

function nextSlide() {
    currentSlide++;
    showSlide(currentSlide);
}

function prevSlide() {
    currentSlide--;
    showSlide(currentSlide);
}

function updateCounter() {
    var counters = document.querySelectorAll('.current');
    for (var i = 0; i < counters.length; i++) {
        counters[i].textContent = currentSlide;
    }
}

function updateProgress() {
    var bar = document.querySelector('.progress-bar');
    if (bar) {
        var pct = (currentSlide / totalSlides) * 100;
        bar.style.width = pct + '%';
    }
}

document.addEventListener('keydown', function(e) {
    if (e.key === 'ArrowRight' || e.key === ' ' || e.key === 'Spacebar') {
        e.preventDefault();
        nextSlide();
    }
    if (e.key === 'ArrowLeft') {
        e.preventDefault();
        prevSlide();
    }
});

var touchStartX = 0;
var touchEndX = 0;

document.addEventListener('touchstart', function(e) {
    touchStartX = e.changedTouches[0].screenX;
}, {passive: true});

document.addEventListener('touchend', function(e) {
    touchEndX = e.changedTouches[0].screenX;
    handleSwipe();
}, {passive: true});

function handleSwipe() {
    var diff = touchStartX - touchEndX;
    if (Math.abs(diff) > 50) {
        if (diff > 0) {
            nextSlide();
        } else {
            prevSlide();
        }
    }
}

showSlide(currentSlide);
