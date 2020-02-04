export function FormatDate(dateString) {
  const date = new Date(dateString);
  const year = date.getFullYear();
  const month = date.getMonth() + 1;
  const monthTwoDigits = ('0' + month).slice(-2);

  return `${year}-${monthTwoDigits}`;
}
