import React, { useState, useEffect } from 'react'
import ReactDOM from 'react-dom'
import { DragDropContext } from 'react-beautiful-dnd'
import PropTypes from 'prop-types'
import consumer from '../channels/consumer'
import CardBoard from './CardBoard'

const CandidatesIndex = () => {
  const [data, setData] = useState(null)

  useEffect(() => {
    async function fetchData() {
      await fetch('/candidates.json')
      .then(res => res.json())
      .then(res => {setData(res)})
    }
    fetchData()
  }, [])

  if(!data) { return(null) }

  consumer.subscriptions.create("CandidatesChannel", {
    connected() { console.log('Connected to candidates channel !') },
    received(data) {
      const updatedCandidate = data.updatedCandidate

      updateCandidate(updatedCandidate)
    }
  });

  const updateCandidate = (updatedCandidate) => {
    setData({
      status:     data.status,
      candidates: data.candidates.map((candidate) => {
        if(candidate.id === updatedCandidate.id) {
          candidate.status = updatedCandidate.status
        }

        return(candidate)
      })
    })
  }

  const onDragEnd = result => {
    const { destination, source, draggableId } = result

    if(!destination) { return; }

    if(
      destination.droppableId === source.droppableId &&
      destination.index === source.index
    ) { return; }

    fetch(`/update_status/${draggableId}/${destination.droppableId}`, { method: 'post' })
  }

  return(
    <DragDropContext onDragEnd={onDragEnd}>
      <div className='candidates-react-component'>
        {
          data.status.map((status, index) => {
            return(
              <CardBoard
                title={status}
                candidates={data.candidates.filter((candidate) => { return(candidate.status === status) })}
                key={index}
              />
            )
          })
        }
      </div>
    </DragDropContext>
  )
}

CandidatesIndex.propTypes = { name: PropTypes.string }

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <CandidatesIndex name="React" />,
    document.body.appendChild(document.createElement('div')),
  )
})
