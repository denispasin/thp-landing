const main = () => {
  const form = document.getElementById('the-form');

  const onSubmit = (e) => {
    e.preventDefault();

    const fields = Array.from(e.target.elements);
    console.log({fields});
    const name = fields.find(e => e.name === 'name').value;
    const email = fields.find(e => e.name === 'email').value;
    console.log({name, email});

    fetch(`./api/to_google_doc?name=${encodeURIComponent(name)}&email=${encodeURIComponent(email)}`)

    e.target.reset(); 
  };

  form.addEventListener('submit', onSubmit);
}

main()