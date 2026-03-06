/** @type {import('tailwindcss').Config} */
module.exports = {
    content: [
        "./Resources/Views/**/*.leaf",
    ],
    theme: {
        extend: {
            fontFamily: {
                sans: ['Inter', 'system-ui', 'sans-serif'],
            },
        },
    },
    plugins: []
}
