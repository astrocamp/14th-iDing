import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="tablemap"
export default class extends Controller {
  static targets = ["table", "editBtn", "finishBtn", "empty", "hint", "order"];

  startEdit() {
    const tables = this.tableTargets;
    const emptyDivs = this.emptyTargets;
    const hint = this.hintTarget;
    //show hint
    hint.classList.remove("hidden");
    //change editBtn
    this.editBtnTarget.disabled = true;
    this.editBtnTarget.classList.remove("action-btn");
    this.editBtnTarget.classList.add("void-btn");
    //change finishBtn
    this.finishBtnTarget.disabled = false;
    this.finishBtnTarget.classList.remove("void-btn");
    this.finishBtnTarget.classList.add("action-btn");
    //setBorder
    emptyDivs.forEach((div) => {
      div.style.border = "0.5px solid gray";
    });
    // hidden reservation
    this.orderTargets.forEach((target) => {
      target.classList.add("hidden");
    });
    //editMode
    tables.forEach((button) => {
      button.setAttribute("data-action", "keydown->tablemap#handleArrowKey");
      button.style.border = "0.5px solid gray";
    });
  }

  finishEdit() {
    const tables = this.tableTargets;
    const emptyDivs = this.emptyTargets;
    const hint = this.hintTarget;
    //remove hint
    hint.classList.add("hidden");
    //change finishBtn
    this.finishBtnTarget.disabled = true;
    this.finishBtnTarget.classList.remove("action-btn");
    this.finishBtnTarget.classList.add("void-btn");
    //change finishBtn
    this.editBtnTarget.disabled = false;
    this.editBtnTarget.classList.remove("void-btn");
    this.editBtnTarget.classList.add("action-btn");
    //removeBorder
    emptyDivs.forEach((div) => {
      div.style.removeProperty("border");
    });
    //finishEdit
    tables.forEach((button) => {
      button.setAttribute("data-action", "click->tablemap#showOrder");
      button.style.removeProperty("border");
    });
  }

  handleArrowKey(event) {
    const tableId = event.currentTarget.dataset.id;
    const tableTarget = this.tableTargets.find(
      (target) => target.dataset.id === tableId
    );
    if (!tableTarget) {
      return;
    }

    let gridArea = tableTarget.style.gridArea;
    const [startY, startX, endY, endX] = gridArea.split("/").map(Number);
    event.preventDefault();
    switch (event.key) {
      case "ArrowUp":
        if (startY > 1) {
          this.moveUp(tableTarget);
          this.updatePosition(startX, startY - 1, tableId);
        }
        break;

      case "ArrowDown":
        if (startY < 20) {
          this.moveDown(tableTarget);
          this.updatePosition(startX, startY + 1, tableId);
        }
        break;

      case "ArrowLeft":
        if (startX > 1) {
          this.moveLeft(tableTarget);
          this.updatePosition(startX - 1, startY, tableId);
        }
        break;

      case "ArrowRight":
        if (startX < 46) {
          this.moveRight(tableTarget);
          this.updatePosition(startX + 1, startY, tableId);
        }
        break;
    }
  }

  updatePosition(newX, newY, tableId) {
    const requestBody = {
      site_x: newX,
      site_y: newY,
    };
    fetch(`/api/v1/tables/${tableId}/update_position`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name=csrf-token]").content,
      },
      body: JSON.stringify(requestBody),
    })
      .then((response) => {
        if (!response.ok) {
          throw new Error("請求失敗");
        }
        return response.json();
      })
      .catch((error) => {});
  }

  moveRight(element) {
    moveElement(element, 1, 0);
  }

  moveLeft(element) {
    moveElement(element, -1, 0);
  }

  moveUp(element) {
    moveElement(element, 0, -1);
  }

  moveDown(element) {
    moveElement(element, 0, 1);
  }

  showOrder(event) {
    // 找桌子id
    const tableId = event.currentTarget.dataset.id;
    // 找到與該桌子的訂單target
    const orderTarget = this.orderTargets.find(
      (target) => target.dataset.id === tableId
    );
    // 如果點擊同一個桌子，就隱藏訂單
    if (tableId === this.clickedTableId) {
      orderTarget.classList.add("hidden");
      this.clickedTableId = null; // 重置點擊的桌子
    } else {
      // 否則，隱藏所有訂單元素，並顯示相關的訂單
      this.orderTargets.forEach((target) => {
        target.classList.add("hidden");
      });
      if (orderTarget) {
        orderTarget.classList.remove("hidden");
        const valuex = event.currentTarget.getAttribute("valuex");
        if (parseInt(valuex) < 40) {
          orderTarget.style.transform = "translate(80px, -120px)";
        } else {
          orderTarget.style.transform = "translate(-180px, -120px)";
        }
      }
      this.clickedTableId = tableId; // 設置當前點擊的桌子
    }
  }
}

function moveElement(element, xChange, yChange) {
  const gridArea = element.style.gridArea;
  const [startY, startX, endY, endX] = gridArea.split("/").map(Number);
  const newStartX = startX + xChange;
  const newEndX = endX + xChange;
  const newStartY = startY + yChange;
  const newEndY = endY + yChange;
  element.style.gridArea = `${newStartY} / ${newStartX} / ${newEndY} / ${newEndX}`;
}
