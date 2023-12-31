let payjp;

const pay = () => {
  const url = new RegExp(/\/items\/\d+\/orders/);
  if(!url.test(location.pathname)){
    return;
  }
  
  //const payjp = Payjp(publicKey)
  if (!payjp) {
    const publicKey = gon.public_key
    payjp = Payjp(publicKey)
  }
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');
  const from = document.getElementById("charge-form");
  from.addEventListener("submit",(e) =>{
    e.preventDefault();
    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
      } else {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("turbo:load", pay);
