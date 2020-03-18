import React from 'react'
import { Draggable } from 'react-beautiful-dnd';
import PropTypes from 'prop-types'

const Card = ({candidate, index}) => {
  if(!candidate) { return null }

  return(
    <Draggable draggableId={`${candidate.id}`} index={index}>
      {(provided) => (
        <div
          className='card'
          {...provided.draggableProps}
          {...provided.dragHandleProps}
          ref={provided.innerRef}
        >
          {candidate.firstName + ' ' + candidate.lastName}
        </div>
      )}
    </Draggable>
  )
}

Card.propTypes = { candidate: PropTypes.object }

export default Card