/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

const categoryCheckboxSelector = '.category-list-item input[type="checkbox"]';
const examCheckboxSelector = '.exams-list-item input[type="checkbox"]';
document.addEventListener('turbolinks:load', () => {
  const categoryCheckboxes = document.querySelectorAll(categoryCheckboxSelector);
  Array.from(categoryCheckboxes).forEach((categoryCheckbox) => {
    categoryCheckbox.addEventListener('change', toggleCategoryExams);
  });
  const examsCheckboxes = document.querySelectorAll(examCheckboxSelector);
  Array.from(examsCheckboxes).forEach((examCheckbox) => {
    examCheckbox.addEventListener('change', toggleExamsCategory);
  });
})

function toggleCategoryExams(event) {
  const categoryCheckbox = event.target;
  const categoryContainer = categoryCheckbox.closest('.category');
  const examsCheckboxes =
    categoryContainer.querySelectorAll(examCheckboxSelector);
  Array.from(examsCheckboxes).forEach((examCheckbox) => {
    examCheckbox.checked = categoryCheckbox.checked;
  });
}

function toggleExamsCategory(event) {
  const examCheckbox = event.target;
  const categoryContainer = examCheckbox.closest('.category');
  const categoryCheckbox = categoryContainer.querySelector(categoryCheckboxSelector);
  const examsCheckboxes =
    categoryContainer.querySelectorAll(examCheckboxSelector);
  const allChecked = Array.from(examsCheckboxes).every((examCheckbox) => {
    return examCheckbox.checked;
  });
  if (allChecked) {
    categoryCheckbox.checked = true;
  } else {
    categoryCheckbox.checked = false;
  }
}
