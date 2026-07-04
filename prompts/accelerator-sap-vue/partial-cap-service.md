# CAP Service Implementation Prompt

You are implementing a CAP service handler. Follow these patterns:

1. Define CDS entities in `db/schema.cds` with Fiori annotations
2. Create service in `srv/<feature>/<feature>.js`
3. Implement handlers: `on` (custom logic), `before` (validation), `after` (enrichment)
4. Use `@sap/cds` queries with `SELECT.from`, `INSERT.into`, `UPDATE.entity`, `DELETE.from`
5. Handle errors with `req.reject()` or `req.error()`
6. Add authorization checks via `@requires` annotation or `req.user`

Structure:
```js
const cds = require('@sap/cds')

module.exports = cds.service.impl(async function() {
  const { MyEntity } = this.entities

  this.on('READ', MyEntity, async (req) => {
    // Impl
  })
})
```
