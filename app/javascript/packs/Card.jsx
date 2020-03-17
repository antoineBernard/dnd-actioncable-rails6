import React from 'react'
import PropTypes from 'prop-types'

const Card = ({candidate}) => {
  if(!candidate) { return null }

  const updateData = () => {
    fetch(`/update_status/${candidate.id}/hr_interview`, { method: 'post' })
  }

  return(
    <div className='card' onClick={updateData}>
      {candidate.firstName + ' ' + candidate.lastName}
    </div>
  )
}

Card.propTypes = { candidate: PropTypes.object }

export default Card