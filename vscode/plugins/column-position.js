(function () {
  function updateColumnPosition() {
    const positionLabel = document.querySelector(
      "#status\\.editor\\.selection .statusbar-item-label"
    );
    if (!positionLabel || !positionLabel.textContent) {
      // It might not exist for some reason ¯\_(Ä)_/¯
      return;
    }

    const currentLine = document.querySelector(
      ".line-numbers.active-line-number"
    );
    if (!currentLine) {
      return; // It also can be `null` in some cases
    }

    // Now we would have the column position instead of the active line number:
    const colNumber = positionLabel.textContent.match(/Col (\d+)/);
    if (!colNumber) {
      return; // Column was not there
    }
    currentLine.textContent = colNumber[1];
  }

  updateColumnPosition();
  setInterval(updateColumnPosition, 50);
})();
