document.addEventListener('DOMContentLoaded', () => {
    // DOM elements
    const daysInput = document.getElementById('days');
    const hoursInput = document.getElementById('hours');
    const minutesInput = document.getElementById('minutes');
    const secondsInput = document.getElementById('seconds');
    
    const displayDays = document.getElementById('displayDays');
    const displayHours = document.getElementById('displayHours');
    const displayMinutes = document.getElementById('displayMinutes');
    const displaySeconds = document.getElementById('displaySeconds');
    
    const startBtn = document.getElementById('startBtn');
    const resetBtn = document.getElementById('resetBtn');
    
    // Variables
    let countdownInterval;
    let totalSeconds = 0;
    let isRunning = false;
    
    // Event listeners
    startBtn.addEventListener('click', toggleCountdown);
    resetBtn.addEventListener('click', resetCountdown);
    
    // Input validation - ensure at least one field has a value > 0
    [daysInput, hoursInput, minutesInput, secondsInput].forEach(input => {
        input.addEventListener('input', validateInputs);
    });
    
    // Functions
    function validateInputs() {
        const days = parseInt(daysInput.value) || 0;
        const hours = parseInt(hoursInput.value) || 0;
        const minutes = parseInt(minutesInput.value) || 0;
        const seconds = parseInt(secondsInput.value) || 0;
        
        const hasValue = days > 0 || hours > 0 || minutes > 0 || seconds > 0;
        startBtn.disabled = !hasValue;
        
        // Update display with current input values
        if (!isRunning) {
            displayDays.textContent = formatTime(days);
            displayHours.textContent = formatTime(hours);
            displayMinutes.textContent = formatTime(minutes);
            displaySeconds.textContent = formatTime(seconds);
        }
    }
    
    function toggleCountdown() {
        if (isRunning) {
            // Stop the countdown
            clearInterval(countdownInterval);
            startBtn.textContent = 'Start';
            
            // Enable inputs
            enableInputs(true);
        } else {
            // Calculate total seconds
            const days = parseInt(daysInput.value) || 0;
            const hours = parseInt(hoursInput.value) || 0;
            const minutes = parseInt(minutesInput.value) || 0;
            const seconds = parseInt(secondsInput.value) || 0;
            
            totalSeconds = days * 86400 + hours * 3600 + minutes * 60 + seconds;
            
            if (totalSeconds <= 0) {
                showFlashMessage('Please enter a valid time for the countdown.', true);
                return;
            }
            
            // Start the countdown
            updateCountdown();
            countdownInterval = setInterval(updateCountdown, 1000);
            startBtn.textContent = 'Pause';
            
            // Disable inputs
            enableInputs(false);
        }
        
        isRunning = !isRunning;
    }
    
    // Flash message function
    function showFlashMessage(message, isError = false) {
        const flashMessage = document.getElementById('flashMessage');
        flashMessage.textContent = message;
        
        // Add appropriate class based on message type
        if (isError) {
            flashMessage.classList.add('error');
        } else {
            flashMessage.classList.remove('error');
        }
        
        flashMessage.classList.add('show');
        
        // Hide the message after 5 seconds
        setTimeout(() => {
            flashMessage.classList.remove('show');
        }, 5000);
    }
    
    function updateCountdown() {
        if (totalSeconds <= 0) {
            clearInterval(countdownInterval);
            showFlashMessage('Countdown finished!');
            resetCountdown();
            return;
        }
        
        totalSeconds--;
        
        // Calculate days, hours, minutes, seconds
        const days = Math.floor(totalSeconds / 86400);
        const hours = Math.floor((totalSeconds % 86400) / 3600);
        const minutes = Math.floor((totalSeconds % 3600) / 60);
        const seconds = totalSeconds % 60;
        
        // Update display
        displayDays.textContent = formatTime(days);
        displayHours.textContent = formatTime(hours);
        displayMinutes.textContent = formatTime(minutes);
        displaySeconds.textContent = formatTime(seconds);
    }
    
    function resetCountdown() {
        clearInterval(countdownInterval);
        isRunning = false;
        startBtn.textContent = 'Start';
        
        // Reset inputs
        daysInput.value = 0;
        hoursInput.value = 0;
        minutesInput.value = 0;
        secondsInput.value = 0;
        
        // Reset display
        displayDays.textContent = '00';
        displayHours.textContent = '00';
        displayMinutes.textContent = '00';
        displaySeconds.textContent = '00';
        
        // Enable inputs
        enableInputs(true);
        
        // Disable start button until valid input
        startBtn.disabled = true;
    }
    
    function enableInputs(enable) {
        daysInput.disabled = !enable;
        hoursInput.disabled = !enable;
        minutesInput.disabled = !enable;
        secondsInput.disabled = !enable;
    }
    
    function formatTime(time) {
        return time < 10 ? `0${time}` : time;
    }
    
    // Initialize
    validateInputs();
});
