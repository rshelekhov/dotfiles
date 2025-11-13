(function () {
  function updateTabWithBranch() {
    const branchLabel = document.querySelector(
      "#status\\.scm\\.0 .statusbar-item-label"
    );
    if (!branchLabel) {
      // No `git` or `.git/`, no branch label, or something similar
      return;
    }
    const separator = " | ";
    const attrName = "data-initial-name";

    const tab = document.querySelector(".single-tab .label-description");
    if (!tab) {
      return; // tab might not be there
    }

    if (tab.textContent.indexOf(separator) === -1) {
      // Initial case:
      tab.setAttribute(attrName, tab.textContent);
    }

    // Branch name might be changed, needs an update:
    const originalName = tab.getAttribute(attrName);
    tab.textContent = `${originalName}${separator}${branchLabel.textContent}`;
  }

  updateTabWithBranch();
  setInterval(updateTabWithBranch, 50);
})();
