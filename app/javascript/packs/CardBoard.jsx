import React from 'react'
import PropTypes from 'prop-types'
import Card from './Card'

const CardBoard = ({title, candidates}) => {
  return(
    <div className='card-board'>
      <div className='title'>{title}<span>{candidates.length}</span></div>
      {
        candidates.map((candidate, index) => {
          return(
            <Card candidate={candidate} key={index}/>
          )
        })
      }
      <Card />
    </div>
  )
}

CardBoard.propTypes = {
  title: PropTypes.string,
  candidates: PropTypes.array
}

export default CardBoard