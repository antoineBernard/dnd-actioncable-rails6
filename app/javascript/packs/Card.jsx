import React from 'react'
import { Draggable } from 'react-beautiful-dnd';
import { thumbsUp, ThumbsUp, MessageSquare, User } from 'react-feather'
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
          <div className='info-candidate'>
            <User />
            <div className='description'>
              <div className='fullname'>{candidate.firstName + ' ' + candidate.lastName}</div>
              <div className='job-title'>{candidate.jobTitle}</div>
            </div>
          </div>
          <div className='stats'>
            <span className='score'>{candidate.score}</span>
            <span><ThumbsUp      size={13} />{candidate.likes}</span>
            <span><MessageSquare size={13} />{candidate.rank}</span>
          </div>
        </div>
      )}
    </Draggable>
  )
}

Card.propTypes = { candidate: PropTypes.object }

export default Card