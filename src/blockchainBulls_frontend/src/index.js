import { blockchainBulls_backend } from "../../declarations/blockchainBulls_backend";

const bids = [];

async function loadAuctions() {

}

async function refreshBidsForAuction() {
  const container = document.getElementById("bids-list");
  container.innerText = "";

  for(const bid of bids) {
    container.innerHTML = `${container.innerHTML}\n<a class="list-group-item list-group-item-action" id="list-home-list" data-bs-toggle="list" href="#list-home" role="tab" aria-controls="list-home">${bid.bidderName} bids R${bid.amount}</a>`
  }
}

async function addAuction() {

}

async function placeBid() {
  const bidderName = prompt("What is your bidder name?");
  const amount = Math.round(Math.random()*200);

  // ---- place bid

  bids.push({
    bidderName,
    amount,
  });

  refreshBidsForAuction();
}

async function reloadPage() {}

document.querySelector("form").addEventListener("submit", async (e) => {
  e.preventDefault();
  const button = e.target.querySelector("button");

  const name = document.getElementById("name").value.toString();

  button.setAttribute("disabled", true);

  // Interact with foo actor, calling the greet method
  const greeting = await blockchainBulls_backend.greet(name);

  button.removeAttribute("disabled");

  document.getElementById("greeting").innerText = greeting;

  return false;
});
