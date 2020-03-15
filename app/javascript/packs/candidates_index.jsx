import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

const CandidatesIndex = props => (
  <div className='hello-react'>Hello {props.name}!</div>
)

CandidatesIndex.propTypes = {
  name: PropTypes.string
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <CandidatesIndex name="React" />,
    document.body.appendChild(document.createElement('div')),
  )
})
