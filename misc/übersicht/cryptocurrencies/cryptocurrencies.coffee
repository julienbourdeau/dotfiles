command: "/usr/bin/curl -s http://www.unmotorized.cc/bitcoin.php"

refreshFrequency: 300000 #ms

style: """
  bottom: 4px
  left: 20px
  color: #fff
  font-family: Helvetica Neue

  table
    border-collapse: collapse
    table-layout: fixed
    -webkit-font-smoothing: antialiased
    -moz-osx-font-smoothing: grayscale

  td
    font-size: 24px
    font-weight: 200
    overflow: hidden
    text-shadow: 0 0 1px rgba(#000, 0.5)

  th
    font-size: 12px
    text-align: left

  .change
    font-size: 18px

  .spacer
    width: 12px

"""


update: (output, domEl) ->
  data  = JSON.parse(output)
  $domEl = $(domEl)

  $domEl.find('#bitcoin .price').text data.bitcoin.price
  $domEl.find('#ethereum .price').text data.ethereum.price
  $domEl.find('#bitcoincash .price').text data.bitcoincash.price
  $domEl.find('#ripple .price').text data.ripple.price
  $domEl.find('#stellar .price').text data.stellar.price

render: (o) -> """
  <table>
    <tr>
      <th>Bitcoin</th>
      <th class='spacer'></th>
      <th>Ethereum</th>
      <th class='spacer'></th>
      <th>Bitcoin Cash</th>
      <th class='spacer'></th>
      <th>Ripple</th>
      <th class='spacer'></th>
      <th>Stellar</th>
    </tr>
    <tr>
      <td id="bitcoin"><span class='price'></span> €</td>
      <td></td>
      <td id="ethereum"><span class='price'></span> €</td>
      <td></td>
      <td id="bitcoincash"><span class='price'></span> €</td>
      <td></td>
      <td id="ripple"><span class='price'></span> €</td>
      <td></td>
      <td id="stellar"><span class='price'></span> €</td>
    </tr>
  </table>
"""
