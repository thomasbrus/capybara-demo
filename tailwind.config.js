module.exports = {
  content: ["./app/views/**/*.html.erb", "./app/helpers/**/*.rb", "./app/assets/stylesheets/**/*.css", "./app/javascript/**/*.js"],
  theme: {
    extend: {
      textColor: {
        muted: "#6b7280",
      },
    },
  },
  plugins: [require("@tailwindcss/forms")],
};
