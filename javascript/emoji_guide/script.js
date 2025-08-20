document.addEventListener('DOMContentLoaded', () => {
    const emojiData = [
        {
            emoji: "😊",
            title: "Smiling Face with Smiling Eyes",
            description: "Used to express genuine happiness, joy, or warmth. Perfect for positive messages and friendly conversations."
        },
        {
            emoji: "😂",
            title: "Face with Tears of Joy",
            description: "Used to express something is extremely funny or hilarious. One of the most popular emojis for humorous situations."
        },
        {
            emoji: "❤️",
            title: "Red Heart",
            description: "Represents love, affection, and deep caring. Used to express romantic feelings or strong appreciation."
        },
        {
            emoji: "👍",
            title: "Thumbs Up",
            description: "Indicates approval, agreement, or encouragement. A universal sign for 'good job' or 'I like this'."
        },
        {
            emoji: "🔥",
            title: "Fire",
            description: "Represents something hot, exciting, or trending. Often used to describe something impressive or popular."
        },
        {
            emoji: "✨",
            title: "Sparkles",
            description: "Indicates something new, shiny, or special. Often used to emphasize something clean, beautiful, or magical."
        },
        {
            emoji: "🙏",
            title: "Folded Hands",
            description: "Represents prayer, thankfulness, or a request. Used to express gratitude or to make a plea."
        },
        {
            emoji: "😍",
            title: "Smiling Face with Heart-Eyes",
            description: "Expresses adoration, infatuation, or intense liking. Used when seeing something or someone you love."
        },
        {
            emoji: "🤔",
            title: "Thinking Face",
            description: "Indicates contemplation or consideration. Used when pondering a question or expressing skepticism."
        },
        {
            emoji: "👀",
            title: "Eyes",
            description: "Represents looking, noticing, or paying attention. Often used to indicate interest in gossip or drama."
        }
    ];

    const grid = document.querySelector('.grid');

    // Create and append cards to the grid
    emojiData.forEach(item => {
        const card = document.createElement('div');
        card.className = 'card';
        
        card.innerHTML = `
            <div class="emoji">${item.emoji}</div>
            <div class="title">${item.title}</div>
            <div class="description">${item.description}</div>
        `;
        
        grid.appendChild(card);
    });
});
