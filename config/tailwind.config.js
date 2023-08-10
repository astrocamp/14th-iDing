// const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  content: [
    "./public/*.html",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*.{erb,haml,html,slim}",
  ],
  theme: {
    extend: {
      // fontFamily: {
      //   sans: ["Inter var", ...defaultTheme.fontFamily.sans],
      // },
      colors: {
        green: "#003942",
        brown: "#9D8255",
      },
    },
  },
  // plugins: [
  //   require("@tailwindcss/forms"),
  //   require("@tailwindcss/aspect-ratio"),
  //   require("@tailwindcss/typography"),
  //   require("@tailwindcss/container-queries"),
  //   require("preline"),
  // ],
};
