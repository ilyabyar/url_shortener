class ApiService {
  constructor() {
    this.baseUrl = '/api/v1';
    this.defaultHeaders = { "Content-Type": "application/json" };
    this.csrfToken = document.querySelector('meta[name="csrf-token"]').content;
  }

  linksList() {
    const url = `${this.baseUrl}/links`;
    return fetch(url, { headers: this.defaultHeaders})
  }

  createLink(body) {
    const url = `${this.baseUrl}/links`;
    return fetch(url, {
      method: "POST",
      headers: {
        "X-CSRF-Token": this.csrfToken,
        "Content-Type": "application/json"
      },
      body: JSON.stringify(body)
    })
  }

}

export default new ApiService();
