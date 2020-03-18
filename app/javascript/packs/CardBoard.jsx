import React from 'react'
import { Droppable } from 'react-beautiful-dnd'
import PropTypes from 'prop-types'
import Card from './Card'

const CardBoard = ({title, candidates}) => {
  return(
    <div className='column'>
      <div className='title'>{title}<span>{candidates.length}</span></div>
      <Droppable droppableId={title}>
        {
          (provided) => (
            <div
              className='card-board'
              ref={provided.innerRef}
              {...provided.doppableProps}
            >
              {
                candidates.map((candidate, index) => {
                  return(<Card candidate={candidate} index={index} key={index}/>)
                })
              }
              <Card />
              {provided.placeholder}
            </div>
          )
        }
      </Droppable>
    </div>
  )
}

CardBoard.propTypes = {
  title: PropTypes.string,
  candidates: PropTypes.array
}

export default CardBoard