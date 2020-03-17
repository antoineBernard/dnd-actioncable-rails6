import React from 'react'
import PropTypes from 'prop-types'

const Card = ({candidate}) => {
  if(!candidate) { return null }

  debugger;
  return(
    <div className='card'>
      {candidate.firstName + ' ' + candidate.lastName}
    </div>
  )
}

Card.propTypes = { candidate: PropTypes.object }

export default Card